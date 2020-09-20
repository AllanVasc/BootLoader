org 0x7e00
jmp 0x0000:start

data:   ;Todos os dados do programa ficarão aqui

    mensagem db 'Comecamos o projeto hahaha',0
    string times 20 db 0
    X times 10 db 0
    valor times 10 db 0

gets:   ;leitor de string (Com atualização para permitir backspace)

    xor cx, cx  ;Contador utilizado para permitir backspace

    .loop1:

        call getchar    ;Função para ler um char!
        cmp al, 0x08    ;Backspace
        je .backspace   ;Tratar do backSpace

        cmp al, 0x0d    ;Ve se foi inserido o enter (0x0d == 13)
        je .done

        cmp cl, 10      ;Limite da String
        je .loop1
    
        stosb           ;Vai guardar o char em AL para o DI       
        inc cl          ;Vai inc o contador de caracteres
        call putchar    ;Printa a letra
    
        jmp .loop1

    .backspace:

        cmp cl, 0       ;Conferindo para saber se já esta vazio
        je .loop1

        dec di          ;Deletando o ultimo char inserido
        dec cl
        mov byte[di], 0
        call delchar

        jmp .loop1

    .done:
    
        mov al, 0
        stosb
        call endl
        ret
    
getchar:    ;Pega o caractere lido no teclado e salva em al

    mov ah, 0x00
    int 16h
    ret

delchar:    ;Deleta um caractere lido no teclado

    mov al, 0x08          ;BackSpace
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x08          ;BackSpace
    call putchar
    ret
  
endl:       ;Pula uma linha, printando na tela o caractere que representa o /n

    mov al, 0x0a          ; line feed
    call putchar
    mov al, 0x0d          ; carriage return
    call putchar
    ret

prints: ;mov si, string (Vai printar a string que o SI esta apontando)

    .loop:
        lodsb           ; bota character apontado por si em al 
        cmp al, 0       ; 0 é o valor atribuido ao final de uma string
        je .endloop     ; Se for o final da string, acaba o loop
        call putchar    ; printa o caractere
        jmp .loop       ; volta para o inicio do loop

    .endloop:
        ret

putchar:    ;Função responsavel por printar um caracter

    mov ah, 0x0e
    int 10h
    ret

clear:  ;Função para limpar a tela (mov bl, color)                    
 
    mov dx, 0       ;Set the cursor to top left-most corner of screen
    mov bh, 0      
    mov ah, 0x2
    int 0x10
    
    mov cx, 2000    ;Print 2000 blank chars to clean
    mov bh, 0
    mov al, 0x20    ;Blank char
    mov ah, 0x9
    int 0x10
    
    mov dx, 0       ;Reset cursor to top left-most corner of screen
    mov bh, 0      
    mov ah, 0x2
    int 0x10
    ret

start:
    
    xor ax, ax      ;limpando ax
    mov ds, ax      ;limpando ds
    mov es, ax      ;limpando es

    mov bl,15       ;Cor da String em bl
    call clear      ;Limpando a tela

    mov si, mensagem    ;Imprimindo mensagem
    call prints         ;Printa string
    call endl           ;Pula uma linha

done:

    jmp $






;---------------------------------------------------------------------------------------------------------------------
;Funções que talvez use

tostring:              ; mov ax, int / mov di, string, transforma o valor em ax em uma string e salva no endereço apontado por di
    push di
    .loop1:
        cmp ax, 0
        je .endloop1
        xor dx, dx
        mov bx, 10
        div bx            ; ax = 9999 -> ax = 999, dx = 9
        xchg ax, dx       ; swap ax, dx
        add ax, 48        ; 9 + '0' = '9'
        stosb
        xchg ax, dx
        jmp .loop1
    .endloop1:
    pop si
    cmp si, di
    jne .done
    mov al, 48
    stosb
    .done:
    mov al, 0
    stosb
    call reverse
    ret

reverse:              ; mov si, string , pega a string apontada por si e a reverte 
  mov di, si
  xor cx, cx          ; zerar contador
  .loop1:             ; botar string na stack
    lodsb
    cmp al, 0
    je .endloop1
    inc cl
    push ax
    jmp .loop1
  .endloop1:
  .loop2:             ; remover string da stack        
    pop ax
    stosb
    loop .loop2
  ret

strcmp:              ; mov si, string1, mov di, string2, compara as strings apontadas por si e di
  .loop1:
    lodsb
    cmp al, byte[di]
    jne .notequal
    cmp al, 0
    je .equal
    inc di
    jmp .loop1
  .notequal:
    clc
    ret
  .equal:
    stc
    ret