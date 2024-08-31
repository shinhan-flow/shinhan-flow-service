from flask import Flask, request, jsonify
from utils import *
from chat import *
import argparse

app = Flask(__name__)

ROOT_DIR = find_root_dir()


def set_flow(user_id="", prompt=""):
    parser = argparse.ArgumentParser(description="Example script with arguments")
    # parser.add_argument('-n', '--name', type=str, help='Name of the user', required=True)
    parser.add_argument(
        "-u", "--user_id", type=int, help="enter user's id", required=False, default=0
    )
    parser.add_argument(
        "-r",
        "--request",
        type=str,
        help="enter user's request",
        required=False,
        default="계좌의 잔액이 1000보다 작다면, 사랑해 알림을 보내",
    )
    parser.add_argument(
        "-m",
        "--model_num",
        type=int,
        help="choose model's number",
        required=False,
        default=4,
    )
    args = parser.parse_args()

    # 플로우 생성 요청하기
    if prompt:
        try:
            my_flow = create_flow(prompt, args.model_num)
        except:
            my_flow = {"error": "100", "message": "AI: sorry, My mistake"}

    else:
        my_flow = create_flow(args.request, args.model_num)

    return my_flow


# 홈 경로
@app.route("/")
def home():
    return "Flask 서버가 실행 중입니다!"


# 문자열 데이터를 주고받는 경로
@app.route("/process", methods=["POST"])
def process_string():
    data = request.json
    input_string = data.get("input_string", "")

    processed_string = set_flow(prompt=input_string)

    # 처리된 문자열을 JSON 형식으로 반환
    return jsonify({"processed_string": processed_string})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
