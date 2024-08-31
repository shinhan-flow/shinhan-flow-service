from utils import *
from chat import *
import argparses

# with open(f'{ROOT_DIR}/thread.pickle','wb') as f:
#     pickle.dump({}, f)
# 루트 경로 찾기
ROOT_DIR = find_root_dir()


def main(user_id="", prompt=""):
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
        default=3,
    )
    args = parser.parse_args()

    # 플로우 생성 요청하기
    if user_id and prompt:
        my_flow = create_flow(prompt, args.model_num)
    else:
        my_flow = create_flow(args.request, args.model_num)
    print(my_flow)


if __name__ == "__main__":
    main()
