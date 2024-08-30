import openai

# First, we create a EventHandler class to define
# how we want to handle the events in the response stream.


client = openai.OpenAI(api_key=os.getenv("API_KEY"))

assistant = client.beta.assistants.create(
    name="똑똑한 비서",
    description="당신은 똑똑한 비서입니다.",
    model="gpt-4-1106-preview",
)


thread = client.beta.threads.create(
    messages=[
        {
            "role": "user",
            "content": "의자는 숫자 1, 책상은 숫자 2, 식탁은 숫자 3이야. 의자+책상=??",
        }
    ]
)
run = client.beta.threads.runs.create(
    thread_id=thread.id,
    assistant_id=assistant.id,
    # model="gpt-4-1106-preview",
    # instructions="additional instructions",
    # tools=[{"type": "code_interpreter"}, {"type": "retrieval"}]
)


import time

while True:
    run_check = client.beta.threads.runs.retrieve(thread_id=thread.id, run_id=run.id)
    if run_check.status in ["queued", "in_progress"]:
        time.sleep(0)
    else:
        break


thread_messages = client.beta.threads.messages.list(thread.id)
for msg in thread_messages.data:
    print(f"{msg.role}: {msg.content[0].text.value}")


new_message = client.beta.threads.messages.create(
    thread_id=thread.id,
    role="user",
    content="식탁+의자??",
)

run = client.beta.threads.runs.create(thread_id=thread.id, assistant_id=assistant.id)
while True:
    run_check = client.beta.threads.runs.retrieve(thread_id=thread.id, run_id=run.id)
    run_check
    if run_check.status not in ["queued", "in_progress"]:
        break
    else:
        time.sleep(0)

thread_messages = client.beta.threads.messages.list(thread.id)
for msg in thread_messages.data:
    print(f"{msg.role}: {msg.content[0].text.value}")

print("final start")

new_message2 = client.beta.threads.messages.create(
    thread_id=thread.id,
    role="user",
    content="내가 그동안 했던 질문을 리스트로 정리해줘",
)

run = client.beta.threads.runs.create(thread_id=thread.id, assistant_id=assistant.id)
while True:
    run_check = client.beta.threads.runs.retrieve(thread_id=thread.id, run_id=run.id)
    run_check
    if run_check.status not in ["queued", "in_progress"]:
        break
    else:
        time.sleep(0)

thread_messages = client.beta.threads.messages.list(thread.id)
for msg in thread_messages.data[::-1]:
    print(f"{msg.role}: {msg.content[0].text.value}")
