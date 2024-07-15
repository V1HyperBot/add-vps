import subprocess

command = input("Silakan masukkan kode encrypted anda: ")

try:
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print("Error:", e.stderr)
