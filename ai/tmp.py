import os
import openai
from cryptography.fernet import Fernet
import logging
from datetime import datetime
import re

# 환경 변수에서 API 키 불러오기
api_key = os.getenv("OPENAI_API_KEY")

if not api_key:
    raise ValueError("API 키가 설정되지 않았습니다. 환경 변수 'OPENAI_API_KEY'를 설정하세요.")

openai.api_key = api_key

# 암호화 키 생성 (한 번만 생성하고 안전한 장소에 저장하세요)
encryption_key = Fernet.generate_key()

# Fernet 객체 생성
cipher_suite = Fernet(encryption_key)

# 사용자 역할 설정
roles = {
    "admin": {"can_access_sensitive_data": True},
    "user": {"can_access_sensitive_data": False}
}

# 현재 사용자 역할 (실제 애플리케이션에서는 사용자 인증을 통해 역할을 부여해야 합니다)
current_user_role = "user"

# 로그 설정
logging.basicConfig(filename='access_log.txt', level=logging.INFO)

def log_access(action, success=True):
    """접근 로그를 기록합니다."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "SUCCESS" if success else "FAILED"
    log_message = f"[{timestamp}] {action} - {status}"
    logging.info(log_message)

def encrypt_data(data):
    """데이터를 암호화합니다."""
    return cipher_suite.encrypt(data.encode())

def decrypt_data(encrypted_data):
    """암호화된 데이터를 복호화합니다."""
    return cipher_suite.decrypt(encrypted_data).decode()

def validate_input(input_text):
    """입력 데이터를 검증합니다."""
    if not isinstance(input_text, str):
        raise ValueError("입력은 문자열이어야 합니다.")
    
    # 악의적인 SQL 인젝션 패턴 검출
    if re.search(r"(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(?:;)|(\b(ALTER|CREATE|DELETE|DROP|EXEC(UTE)?|INSERT|MERGE|SELECT|UPDATE|UNION|USE)\b)", input_text, re.IGNORECASE):
        raise ValueError("악의적인 입력이 감지되었습니다.")
    
    return input_text

def anonymize_data(data):
    """민감한 정보를 비식별화합니다."""
    # 예: 이메일 주소와 같은 민감한 데이터를 비식별화
    anonymized_data = re.sub(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', '[REDACTED]', data)
    
    # 추가적인 민감한 정보가 있다면 여기에 더 추가
    return anonymized_data

def ask_openai(question):
    try:
        # 입력 데이터 검증
        validated_question = validate_input(question)
        
        # OpenAI에게 질문하기
        response = openai.Completion.create(
            engine="text-davinci-003",  # 사용할 모델 지정
            prompt=validated_question,  # 검증된 질문 사용
            max_tokens=100,             # 응답에서 반환할 최대 토큰 수
            n=1,                        # 반환할 응답의 개수
            stop=None,                  # 응답을 중단시킬 단어 또는 문자
            temperature=0.7,            # 응답의 창의성 조절 (0.0 - 1.0)
        )

        # 응답 추출
        answer = response.choices[0].text.strip()

        # 민감한 정보 비식별화
        anonymized_answer = anonymize_data(answer)

        # 응답을 암호화하여 파일에 저장 (admin 역할만 가능)
        if roles[current_user_role]["can_access_sensitive_data"]:
            encrypted_answer = encrypt_data(anonymized_answer)
            with open("encrypted_response.txt", "wb") as file:
                file.write(encrypted_answer)
            log_access("File write: encrypted_response.txt")
        else:
            log_access("File write: encrypted_response.txt", success=False)
            return "Access Denied: You do not have permission to write sensitive data."

        return anonymized_answer

    except Exception as e:
        log_access("ask_openai execution", success=False)
        return f"Error: {str(e)}"

def read_encrypted_data():
    """암호화된 파일 읽기 (admin 역할만 가능)"""
    if roles[current_user_role]["can_access_sensitive_data"]:
        try:
            with open("encrypted_response.txt", "rb") as file:
                encrypted_data = file.read()
            log_access("File read: encrypted_response.txt")
            return decrypt_data(encrypted_data)
        except FileNotFoundError:
            log_access("File read: encrypted_response.txt", success=False)
            return "File not found."
    else:
        log_access("File read: encrypted_response.txt", success=False)
        return "Access Denied: You do not have permission to read sensitive data."

# 질의 실행
question = "Please send an email to john.doe@example.com"
answer = ask_openai(question)
print("OpenAI의 응답:", answer)

# 암호화된 파일에서 데이터 복호화 및 출력 (현재 사용자 역할에 따라 접근 제한)
decrypted_answer = read_encrypted_data()
print("복호화된 응답:", decrypted_answer)
