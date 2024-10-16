# Daria Shevyrev 1830399
# Elise Wolf 1828204

import numpy as np


def start_tab(A, b, c, B):

    # Dimension der Matrix A bestimmen
    m, n = A.shape

    # Preallocation: Tableau initialisieren
    TB = np.zeros((m+1, n+1))

    # Kosten zur Basis B bestimmen
    c_B = np.zeros(m)

    # Matrix zur Basis B berechnen
    T_B = np.zeros((m, m))
    for j in range(m):
        T_B[:, j] = A[:, B[j]]
        c_B[j] = c[B[j]]

    # Bestimmen des Simplextableaus
    tmp = np.linalg.solve(T_B, A)  # T_B \ A in MATLAB entspricht numpy.linalg.solve in Python

    TB[:m, :n] = tmp
    TB[m, :n] = -(c.T - np.dot(c_B.T, tmp))

    tmp = np.linalg.solve(T_B, b)  # T_B \ b

    TB[:, n] = np.concatenate([tmp, [np.dot(c_B.T, tmp)]])
    
    return TB




def pivot_element(T):
    m, n = T.shape
    m -= 1  # letzte Zeile (Kostenzeile)
    n -= 1  # rechteste Spalte (b)

    # Schritt 1: Pivot-Spalte (s) bestimmen
    cost_z = np.where(T[m, :n-1] > 0)  # Elemente > 0 in der Kostenzeile
    if len(cost_z) == 0:
        return 0, 0  # Keine Spalte wählbar
    else:
        s = np.argmax(T[m, :n-1])  # Wähle die Spalte mit dem größten positiven Wert


    # Schritt 2: Pivot-Zeile (z) bestimmen
    # Quotientenregel: (rechter Rand / positive Einträge in der Pivot-Spalte)
    positiv_z = np.where(T[:m, s] > 0)  # Nur positive Werte in der Pivot-Spalte
    if len(positiv_z) == 0:
        return 0, s  # Keine Zeile wählbar
    else:
        for i in positiv_z:
            T[i, n] = T[i, n] / T[i, s]  # rechter Rand / Pivot-Spalteneintrag
        z = np.argmin(T[:m, n])  # Zeile mit dem kleinsten Element
        print("Pivotzeile: ", z)
    return z + 1, s + 1 

def pivot_op(z, s, T, B):
    z = -1
    s = -1

    m, n = T.shape

    T_new = np.copy(T)

    pivot_element = T[z, s]

    # Schritt 1: Pivotelement auf 1 setzen
    for i in range(n):
        T_new[z, i] = T_new[z, i] / pivot_element
    print ("Pivotzeile nach 1. Umformung: ", T_new[z, :])

    # Schritt 2: Alle anderen Elemente in der Pivotspalte auf 0 setzen
    for i in range(m):
        if i != z:
            T_new[i, :] = T_new[i, :] - T_new[i, :] * T_new[z, :] # Element in Zeile = Element in Zeile - Element in Zeile * Element in Pivotzeile
            print ("Zeile ", i+1, "nach Umformung: ", T_new[i, :])

    # Schritt 3: Neue Basis bestimmen
    B_new = B.copy()
    B_new[z] = s  # Ersetze die Basisvariable in der Pivot-Zeile mit der neuen Pivot-Spalte

    return T_new, B_new


def simplex(A, b, c, B):
    # Starttableau initialisieren
    T = start_tab(A, b, c, B) 
    m, n = A.shape  # Get the dimensions of A correctly

    # Startbasis zulaessig?
    if np.any(T[:m, -1] < 0):  # rechte Seite hat <0 Eintraege
        return T, [], -np.inf  # unzulaessige Loesung

    # Simplex-Algorithmus
    while True:
        if T[m, :n-1].min() < 0:
            break  # Optimale Loesung gefunden
        else:
            z, s = pivot_element(T) # Pivotelement bestimmen
            
            if z == 0 and s == 0:
                return T, [], np.inf # unbeschraenktes LP
            else: 
                T, B = pivot_op(z, s, T, B) # Pivotelementoperation
    
    # Extrahiere die optimale Lösung und den Zielfunktionswert
    x_opt = np.zeros(n)  # Use the correct dimension for the solution vector
    for i, b in enumerate(B):
        x_opt[b] = T[i, -1]  # Optima der Basisvariablen (rechte Seite)

    opt_zfw = T[-1, -1]  # Der optimale Zielfunktionswert befindet sich in der letzten Zelle des Tableaus

    return T, x_opt, opt_zfw




A1 = np.array([[2, 4, 1, 1, 0], [3, 6, 4, 0, 1]])
b1 = np.array([8, 6])
c1 = np.array([1, 1, 1, 0, 0])
B1_1 = np.array([3, 4])
B1_2 = np.array([1, 3])



T1, x1, zfw1 = simplex(A1, b1, c1, B1_1)
print("Test 1: \n")
print("Optimales Tableau: \n", T1)
print("Optimale Loesung: ", x1)
print("Optimaler Zielfunktionswert: ", zfw1)

