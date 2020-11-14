; #########################################################################
; ##                                                                     ##
; ##  Installation:                                                      ##
; ##  1. Autohotkey muss installiert sein.                               ##
; ##  2. Script starten                                                  ##
; ##  3. Dying Light muss im Fenstermodus ausgeführt werden              ##
; ##  4. Ausgangsstellung ist Stuffed Turtle vor der Eingangstüre        ##
; ##     Quaratänezone, Blickrichtung 180° entgegengesetzt               ##
; ##  5. Starten des Bots: ALT + e                                       ##
; ##  6. Vorführung: https://youtu.be/UBgipmKWz50                        ##
; ##  7. Bei Fragen bitte in die Kommentare                              ##
; ##  8. Um den Bot zu beenden F3 reloadet den Bot                       ##
; ##                                                                     ##
; #########################################################################

; #########################################################################
; ##                                                                     ##
; ##                        Starten des Bots: ALT + e                    ##
; ##                        Reload des Bots:  F3                         ##
; ##                                                                     ##
; #########################################################################
!e:: 
    while True 
    { 
        Main()
    } 
return

F3:: Reload return 
; #########################################################################
; ##                                                                     ##
; ##                        Weitere Entwicklungshotkeys                  ##
; ##                                                                     ##
; #########################################################################

; DynTurnX(-633)
F4:: LoopWalk(30, "w") return 
; Mausumkehr
F5:: UmkehrDynTurn(-633, 0) return 
; Laufumkehr
F6:: UmkehrDynMove(30, "w", "s") return 

; Ausgangsposition um Türe zu öffnen sowie überbrücken des Ladebildschirmes.
; Zwei individuellen Pausenzeiten (weil die Ladesequenzen unterschiedlich sind)
TuereSpace(time1, time2){
    ; Figur startet die Mission (Blickrichtung 180° entgegen Tür)
    Loop 30
    {
        Send {f down} ; Auto-repeat consists of consecutive down-events (with no up-events).
        Sleep 1 ; The number of milliseconds between keystrokes (or use SetKeyDelay).
    }
    Send {f up} ; Release the key.
    ; Ladebildschirm
    Sleep %time1%
    Send {Space}
    Sleep %time2%
}

; Figur führt eine gewisse Taste wiederholt aus s = Schrittweite: number, t = Taste: string
LoopWalk(s,t){
    Loop %s%
    {
        Send {%t% down} ; Auto-repeat consists of consecutive down-events (with no up-events).
        Sleep 1 ; The number of milliseconds between keystrokes (or use SetKeyDelay).
    }
    Send {%t% up} ; Release the key.
    Sleep 400
}

; Um Steam zu überlisten ( weil sonst die Maus verrückt spielt, nach bereits einmal Ausführen von MouseOver())
InOutGame(){
    send {Alt down}
    Sleep 100
    send {tab}
    send {Alt up}
    Sleep 100
    send {Alt down}
    Sleep 100
    send {tab}
    send {Alt up}
}

; Figur dreht sich um 180°: 45Grad = 633 / 2 = 317Pixel; 90Grad = 1266 / 2 = 633Pixel; 180Grad = 1266Pixel
DynTurnX(a){
    ; x, y, Geschwindigkeit, Absolut/Relativ
    InOutGame()
    Sleep, 500
    MouseMove, %a%, 0 , 2, R
return -a
}

DynTurnY(a){
    ; x, y, Geschwindigkeit, Absolut/Relativ
    InOutGame()
    Sleep, 500
    MouseMove, 0 , %a%, 2, R
return -a
}

; Figur führt eine gewisse Taste wiederholt aus und umgekehrt; s = Schrittweite: number, forward = Taste für welche Richtung: string, backward = Taste um auf Ausgangspunkt zu kommen(Umkehrung): string
UmkehrDynMove(s, forward, backward){
    LoopWalk(s, forward)
    Sleep, 1500
    LoopWalk(s, backward)
}

; Diese Funktion stellt den Beginn des Ablaufes bis zum Durchbruch da.
; Start: Blickrichtung gegenüber Tür von Außen.
; Ende : Blickrichtung Richtung Schalter auf Durchbruch stehend.
Durchbruch(){
    DynTurnX(1266)
    Sleep 50
    TuereSpace(6000,6000)
    ; Missionsfenster bestätigen
    Send t
    Sleep 1000
    InOutGame()
    Sleep 100
    ; Läuft bis auf Höhe Durchbruch
    LoopWalk(35, "w")
    Sleep 100
    DynTurnX(-135)
    ; Dreht zu Durchbruch (90°)
    Sleep 100
    DynTurnX(633)
    InOutGame()
    LoopWalk(15, "w")
    ; Steht auf Durchbruch
    LoopWalk(40, "Space")
}

UmkehrDynTurn(a,b){
    umkehrWertX := DynTurnX(a)
    umkehrWertY := DynTurnY(b)
    Sleep, 2000
    DynTurnX(umkehrWertX)
    Sleep, 500
    DynTurnY(umkehrWertY)
}

ZuRechteKiste(){
    ; Dreht zur Kiste (45°)
    DynTurnX(220)
    Sleep 500
    InOutGame()
    Sleep 500
    ; hookt / zieht sich zur Kiste
    Click middle
    Sleep 2000
    ; Dreht sich zur Kiste
    DynTurnX(-1266)
    DynTurnY(400)
    InOutGame()
    ; Nimmt die Kiste
    Sleep 400 
    Send f
    Sleep 400
    DynTurnX(-43)
    Sleep 100
    DynTurnY(-263)

    ; Wieder zurück zum Durchbruch
    Sleep 500
    Click middle
    Sleep 2500
    LoopWalk(6, "w")
    DynTurnX(450)
    LoopWalk(30, "w")
    DynTurnX(-633)
    LoopWalk(58 , "w")
    DynTurnX(-630)
    Sleep 100
    LoopWalk(52, "w")
    TuereSpace(8000, 6000)

}

Main(){
    Durchbruch()
    ZuRechteKiste()
return 
}

