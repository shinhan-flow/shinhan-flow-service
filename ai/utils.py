import os

def find_root_dir(target_dir_name="shinhan-flow-service"):
    # 현재 디렉터리로부터 시작
    current_dir = os.getcwd()
    
    while True:
        # 현재 디렉터리가 target_dir인지 확인
        if target_dir_name in os.listdir(current_dir):
            shinhan = os.path.join(current_dir, target_dir_name)
            return os.path.join(shinhan, "ai")
        
        # 상위 디렉터리로 이동
        parent_dir = os.path.dirname(current_dir)
        
        # 루트 디렉터리까지 올라갔을 경우 중단
        if parent_dir == current_dir:
            break
        
        current_dir = parent_dir
    
    return None