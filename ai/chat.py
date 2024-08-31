import openai
import os
from utils import *
import json
from collections import Counter, defaultdict

ROOT_DIR = find_root_dir()
client = openai.OpenAI(api_key=os.getenv("API_KEY"))
assistant = client.beta.assistants.create(
    model="gpt-4o",
)

user_id = ""
recent_requests = []
recent_response = []
N_ITER = 5


# 시스템 설정 로드
with open(f"{ROOT_DIR}/prompt/ver1/explain_flow.json", "r") as f:
    explain_flow = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/set_data_format.json", "r") as f:
    set_data_format = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/enumerate_triggers.json", "r") as f:
    enumerate_triggers = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/enumerate_actions.json", "r") as f:
    enumerate_actions = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/set_output_format.json", "r") as f:
    set_output_format = json.load(f)

model1_system_prompt = [
    explain_flow,
    set_data_format,
    enumerate_triggers,
    enumerate_actions,
    set_output_format,
]

# 에러 검수 로드
with open(f"{ROOT_DIR}/prompt/ver3/check_list.json", "r") as f:
    check_list = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver3/check_trigger_value.json", "r") as f:
    check_trigger_value = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver3/check_action_value.json", "r") as f:
    check_action_value = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver3/error_rule.json", "r") as f:
    error_rule = json.load(f)


model3_error_prompt = [check_list, check_trigger_value, check_action_value, error_rule]


def create_flow(MY_REQUEST, model_num):
    # 기본형
    if model_num == 1:
        print("use model1")
        system_prompt = model1_system_prompt
        chat_completion = client.chat.completions.create(
            messages=[
                *system_prompt,
                {
                    "role": "user",
                    "content": MY_REQUEST,
                },
            ],
            model="gpt-4o-mini",
        )
        return chat_completion.choices[0].message.content

    # 대화연결
    elif model_num == 2:
        print("use model2")
        system_prompt = model1_system_prompt
        messages = [*system_prompt]
        for rq, rp in zip(recent_requests, recent_response):
            messages.append({"role": "user", "content": rq})
            messages.append({"role": "assistant", "content": rp})
        messages.append({"role": "user", "content": MY_REQUEST})

        chat_completion = client.chat.completions.create(
            messages=messages,
            model="gpt-4o-mini",
        )
        return chat_completion.choices[0].message.content

    # 에러 검수
    elif model_num == 3:
        print("use model3")
        system_prompt = model1_system_prompt
        messages = [*system_prompt]
        for rq, rp in zip(recent_requests, recent_response):
            messages.append({"role": "user", "content": rq})
            messages.append({"role": "assistant", "content": rp})
        messages.append({"role": "user", "content": MY_REQUEST})

        chat_completion = client.chat.completions.create(
            messages=messages,
            model="gpt-4o-mini",
        )
        gen_response = chat_completion.choices[0].message.content
        system_prompt = model3_error_prompt
        messages = [*system_prompt]
        messages.append({"role": "user", "content": gen_response})
        chat_completion = client.chat.completions.create(
            messages=messages,
            model="gpt-4o-mini",
        )
        error_response = chat_completion.choices[0].message.content
        if "#$%" in error_response and "ERROR" in error_response:
            return "error"
        else:
            return gen_response
    # SC 기법 적용
    elif model_num == 4:
        print("use model4")
        system_prompt = model1_system_prompt
        messages = [*system_prompt]
        for rq, rp in zip(recent_requests, recent_response):
            messages.append({"role": "user", "content": rq})
            messages.append({"role": "assistant", "content": rp})
        messages.append({"role": "user", "content": MY_REQUEST})

        # SC Generator
        res_case = {}
        for i in range(N_ITER):
            chat_completion = client.chat.completions.create(
                messages=messages,
                model="gpt-4o-mini",
            )
            gen_response = chat_completion.choices[0].message.content
            try:
                tmp = eval(gen_response)
                key = "_".join(
                    sorted([tr["type"] for tr in tmp["triggers"]])
                    + sorted([tr["type"] for tr in tmp["actions"]])
                )
                if not key in res_case:
                    res_case[key] = [1, gen_response]
                else:
                    res_case[key][0] += 1

            except:
                pass
        gen_response = max(res_case.values())[1]
        print(gen_response)
        # SC Error
        system_prompt = model3_error_prompt
        messages = [*system_prompt]
        messages.append({"role": "user", "content": gen_response})

        err_case = Counter()
        for i in range(N_ITER):
            chat_completion = client.chat.completions.create(
                messages=messages,
                model="gpt-4o-mini",
            )
            error_response = chat_completion.choices[0].message.content
            cnt = 0
            for case in [part.strip() for part in error_response.split("#$%")]:
                if case:
                    err_case[case] += 1
                    cnt += 1
            if cnt == 0:
                err_case["not_error"] += 1
            print(err_case)
        err_result = max(err_case.items(), key=lambda x: -x[1])
        print(err_result)
