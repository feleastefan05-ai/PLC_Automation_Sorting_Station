PROGRAM Sortare_Culori
VAR
    button_output : BOOL;
    run_tag_1 : BOOL; run_tag_2 : BOOL; run_tag_3 : BOOL;
    speed_tag_1 : REAL; speed_tag_2 : REAL; speed_tag_3 : REAL;
    running_tag_1 : BOOL; running_tag_2 : BOOL; running_tag_3 : BOOL;
    lamp_tag : BOOL;
    
    // Noul tag de la Photo Eye (BOOL)
    presence_tag : BOOL; 
    
    extend_tag_diverter : BOOL;

    System_Pornit : BOOL := FALSE; 
    Buton_Anterior : BOOL := FALSE;
    Timer_Deviator : TON;
    Trigger_Deviator : BOOL := FALSE;
    Memorie_Cutie : BOOL := FALSE;
END_VAR

// 1. LOGICA DE START/STOP
IF button_output AND NOT Buton_Anterior THEN
    System_Pornit := NOT System_Pornit; 
END_IF;
Buton_Anterior := button_output; 

// 2. CONTROLUL BENZILOR ȘI AL LUMINII
IF System_Pornit THEN
    run_tag_1 := TRUE;   run_tag_2 := TRUE;   run_tag_3 := TRUE;   
    speed_tag_1 := 0.5;  speed_tag_2 := 0.5;  speed_tag_3 := 0.5; 
    lamp_tag := TRUE;    
ELSE
    run_tag_1 := FALSE;  run_tag_2 := FALSE;  run_tag_3 := FALSE;
    lamp_tag := FALSE;
END_IF;

// 3. LOGICA DE SORTARE (Când Photo Eye vede cutia)
IF presence_tag AND System_Pornit AND NOT Memorie_Cutie THEN
    Trigger_Deviator := TRUE; 
    Memorie_Cutie := TRUE; 
END_IF;

// Resetăm memoria când cutia a trecut de senzor
IF NOT presence_tag THEN
    Memorie_Cutie := FALSE;
END_IF;

// 4. TEMPORIZATORUL (Cât stă deviatorul extins)
Timer_Deviator(IN := Trigger_Deviator, PT := T#1s500ms); 

// 5. ACTIUNEA DEVIATORULUI
IF Timer_Deviator.Q THEN
    extend_tag_diverter := FALSE; 
    Trigger_Deviator := FALSE; 
ELSE
    extend_tag_diverter := Trigger_Deviator; 
END_IF;

END_PROGRAM