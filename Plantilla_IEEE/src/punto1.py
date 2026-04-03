"""
Crear un programa en Python que calcule el área del círculo, el
programa debe solicitar al usuario el valor del diámetro del círculo,
se debe validar que este número sea un número, en caso contario
debe indicar error y solicitar que se digite un valor de acuerdo con
lo requerido. Solo terminar hasta que el usuario proporciones todos
los datos, los datos del usuario no pueden estar vacíos. Al finalizar
se debe mostrar en pantalla el valor del diámetro, el valor del radio
y el área calculada del círculo y su perímetro.
"""
import numpy as np
while True:
    diametro_texto = input("Ingrese el valor del diámetro del círculo: ").strip()
    if not diametro_texto:
        print("Error: El valor no puede estar vacío.")
        continue
    try:
        diametro = float(diametro_texto)
        if diametro <= 0:
            print("Error: El diámetro debe ser un número positivo.")
            continue
        break
    except ValueError:
        print("Error: El valor ingresado no es un número válido.")
radio = diametro / 2
area = np.pi * radio ** 2
perimetro = 2 * np.pi * radio
decimales = 2
print(f"\nDiámetro: {diametro:.{decimales}f}")
print(f"Radio: {radio:.{decimales}f}")
print(f"Área del círculo: {area:.{decimales}f}")
print(f"Perímetro del círculo: {perimetro:.{decimales}f}")