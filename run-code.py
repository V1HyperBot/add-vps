import subprocess

command = Input("Silakan masukkan kode encrypted anda: ")

try:
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    exec(result.stdout)
except subprocess.CalledProcessError as e:
    print("Error:", e.stderr)
