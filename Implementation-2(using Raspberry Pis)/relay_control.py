import time
import RPi.GPIO as GPIO

RELAY_PINS = {
    "node1": 17,  # GPIO17 → Relay IN1
    "node2": 27   # GPIO27 → Relay IN2
}

GPIO.setmode(GPIO.BCM)

for pin in RELAY_PINS.values():
    GPIO.setup(pin, GPIO.OUT)
    GPIO.setwarnings(False)
    GPIO.output(pin, GPIO.LOW)  # Active LOW → relay ON → RPi powered

def power_on(node):
    GPIO.output(RELAY_PINS[node], GPIO.HIGH)  # LOW = relay active = Pi ON

def power_off(node):
    GPIO.output(RELAY_PINS[node], GPIO.LOW)


power_off("node1")
power_off("node2")