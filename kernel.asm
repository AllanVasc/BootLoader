org 0x7e00
jmp 0x0000:start

data:   ;Todos os dados do programa ficarão aqui

    ;Strings do Menu
    stringTitle db 'SUDOKU ASM',0
    stringPlay db 'Start Game(1)',0
    stringHowToPlay db 'How To Play(2)',0
    stringCredits db 'Credits(3)',0

    ;Strings do Play
    stringPlayTitle db 'Gameplay',0

    ;Strings do HowToPlay
    stringHowToPlayTitle db 'How To Play',0
    stringHowToPlay1 db 'To solve the puzzle, you must fill in all the empty squares',0
    stringHowToPlay2 db 'without using the same numeral twice in each column, row, or box,',0
    stringHowToPlay3 db 'and without changing the numerals that are already in the grid.',0
    stringHowToPlay4 db 'Good luck, and have fun!', 0
    stringEsc   db 'Press ESC to return...',0

    ;Strings do Credits
    stringCreditsTitle db 'Credits',0
    stringCredits1 db 'Allan Soares Vasconcelos <asv>',0
    stringCredits2 db 'Amanda Lima Lassere <all2>',0
    stringCredits3 db 'Macio Monteiro de Meneses Jr <mmmj>',0
    stringCredits4 db 'Maria Isabel Fernandes dos Santos <mifs>',0

    ;Sudoku

    whiteColor equ 15
    greenColor equ 2
    redColor equ 4

    ; table data
    lineSize dw 145 ; tamanho da linha
    columnSize dw 155 ; tamanho da coluna. Por algum bug desconhecido, tivemos que ir reduzindo o tamanho da coluna
    columnSize1 dw 138
    columnSize2 dw 121
    columnSize3 dw 105
    columnSize4 dw 90
    columnSize5 dw 74
    columnSize6 dw 58
    columnSize7 dw 40
    columnSize8 dw 25
    columnSize9 dw 10
    initialPosx1 dw 250 ; posicao inicial x do primeiro pixel
    initialPosx2 dw 267
    initialPosx3 dw 284
    initialPosx4 dw 299
    initialPosx5 dw 316
    initialPosx6 dw 332
    initialPosx7 dw 347
    initialPosx8 dw 364
    initialPosx9 dw 380
    initialPosx10 dw 396
    initialPosy0 dw 118 ; posicao inicial y do primeiro pixel
    initialPosy1 dw 150
    initialPosy2 dw 182
    initialPosy3 dw 214
    initialPosy4 dw 246
    initialPosy5 dw 278
    initialPosy6 dw 310
    initialPosy7 dw 342
    initialPosy8 dw 374
    initialPosy9 dw 406


    sudokuBackup    db '0',' ','7',' ','4',' ','0',' ','0',' ','0',' ','0',' ','8',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '6',' ','0',' ','0',' ','4',' ','9',' ','1',' ','0',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '2',' ','0',' ','0',' ','0',' ','0',' ','5',' ','4',' ','0',' ','3'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','4',' ','0',' ','0',' ','1',' ','2',' ','3',' ','7',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','3',' ','0',' ','9',' ','4',' ','0',' ','1',' ','0',' ','5'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','5',' ','2',' ','6',' ','0',' ','3',' ','0',' ','4',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','0',' ','1',' ','8',' ','2',' ','0',' ','0',' ','9',' ','4'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '4',' ','0',' ','0',' ','3',' ','0',' ','9',' ','6',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '8',' ','0',' ','5',' ','0',' ','6',' ','0',' ','2',' ','0',' ','0', 0 ;Esse 0 a mais sinaliza o fim!

    sudokuPlaying   db '0',' ','7',' ','4',' ','0',' ','0',' ','0',' ','0',' ','8',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '6',' ','0',' ','0',' ','4',' ','9',' ','1',' ','0',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '2',' ','0',' ','0',' ','0',' ','0',' ','5',' ','4',' ','0',' ','3'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','4',' ','0',' ','0',' ','1',' ','2',' ','3',' ','7',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','3',' ','0',' ','9',' ','4',' ','0',' ','1',' ','0',' ','5'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','5',' ','2',' ','6',' ','0',' ','3',' ','0',' ','4',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','0',' ','1',' ','8',' ','2',' ','0',' ','0',' ','9',' ','4'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '4',' ','0',' ','0',' ','3',' ','0',' ','9',' ','6',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '8',' ','0',' ','5',' ','0',' ','6',' ','0',' ','2',' ','0',' ','0', 0 ;Esse 0 a mais sinaliza o fim!

    sudokuAnswers   db '5',' ','7',' ','4',' ','2',' ','3',' ','6',' ','9',' ','8',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '6',' ','8',' ','3',' ','4',' ','9',' ','1',' ','7',' ','5',' ','2'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '2',' ','1',' ','9',' ','7',' ','8',' ','5',' ','4',' ','6',' ','3'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '9',' ','4',' ','8',' ','5',' ','1',' ','2',' ','3',' ','7',' ','6'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '7',' ','3',' ','6',' ','9',' ','4',' ','8',' ','1',' ','2',' ','5'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '1',' ','5',' ','2',' ','6',' ','7',' ','3',' ','8',' ','4',' ','9'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '3',' ','6',' ','1',' ','8',' ','2',' ','7',' ','5',' ','9',' ','4'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '4',' ','2',' ','7',' ','3',' ','5',' ','9',' ','6',' ','1',' ','8'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '8',' ','9',' ','5',' ','1',' ','6',' ','4',' ','2',' ','3',' ','7', 0 ;Esse 0 a mais sinaliza o fim!

    CanChangeSudoku db '1',' ','0',' ','0',' ','1',' ','1',' ','1',' ','1',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','1',' ','1',' ','0',' ','0',' ','0',' ','1',' ','1',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','1',' ','1',' ','1',' ','1',' ','0',' ','0',' ','1',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '1',' ','0',' ','1',' ','1',' ','0',' ','0',' ','0',' ','0',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '1',' ','0',' ','1',' ','0',' ','0',' ','1',' ','0',' ','1',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '1',' ','0',' ','0',' ','0',' ','1',' ','0',' ','1',' ','0',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '1',' ','1',' ','0',' ','0',' ','0',' ','1',' ','1',' ','0',' ','0'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','1',' ','1',' ','0',' ','1',' ','0',' ','0',' ','1',' ','1'
                    db ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
                    db '0',' ','1',' ','0',' ','1',' ','0',' ','1',' ','0',' ','1',' ','1', 0 ;Esse 0 a mais sinaliza o fim! 

    msgLinhaAtual db 'Linha:' , 0
    msgColunaAtual db 'Coluna:' , 0
    msgCantChange db 'Cant change' , 0

    msgVictory db 'VICTORY!!!' , 0
    msgWrongAnswer db 'Wrong answer... Try Again!' , 0

    linhaSudoku TIMES 2 db 0
    colunaSudoku TIMES 2 db 0

    endl db ' ',13,10,0


prints: ;mov si, string (Vai printar a string que o SI esta apontando)

    .loop:

        lodsb               ; bota character apontado por si em al 
        cmp al, 0           ; 0 é o valor atribuido ao final de uma string
            je .endloop     ; Se for o final da string, acaba o loop
        call putChar        ; printa o caractere

        jmp .loop           ; volta para o inicio do loop

    .endloop:

        ret

printsSudoku:               ; mov si, string (Vai printar a string que o SI esta apontando)

    xor cx, cx              ;Contador utilizado para pular as linhas!

    .loop:

        lodsb               ; bota character em SI para o AL 
        cmp al, 0
            je .endloop

        cmp al, '0'         ;Se for '0' muda a cor para vermelho!
            je .putRed
        
        mov bl, greenColor  ;Se não for, printa o verde!
        call putChar

        inc cx              ;Contando a quantidade de digitos
        cmp cx, 17          ;Se for igual a 17 precisa pular a linha
            je .putEndl

        jmp .loop

    .putRed:

        mov bl, redColor
        call putChar

        inc cx              ;Contando a quantidade de digitos
        cmp cx, 17           ;Se for igual a 17 precisa pular a linha
            je .putEndl

        jmp .loop

    .putEndl:

        xor cx, cx  ;       Zerando novamente o contador!     
        mov al, 13
        call putChar
        mov al, 10
        call putChar
        call colocaEspaco
        jmp .loop

    .endloop:
        ret

colocaEspaco:       ;Usada para centralizar o sudoku no meio da tela

    xor cx,cx

    .loop:

        cmp cx,32   ;Modificar esse número para centralização
            je .done

        mov al, ' '
        call putChar
        inc cx
        
        jmp .loop

    .done:

        xor cx,cx
        ret

putChar:    ;Função responsavel por printar um caracter

    mov ah, 0x0e
    int 10h
    ret
  
putEndl:        ;Pula uma linha, printando na tela o caractere que representa o /n

    mov al, 0x0a    ; line feed
    call putChar
    mov al, 0x0d    ; carriage return
    call putChar
    ret

getChar:    ;Pega o caractere lido no teclado e salva em al

    mov AH, 0x00
    int 16h
    ret

strcpy: ;Função para copiar uma String na outra mov SI, String 1 ; mov DI, String 2 (String 2 <- String 1)

    .loop1:

        lodsb
        stosb
        cmp al, 0
            je .endloop1
        jmp .loop1

    .endloop1:
        ret

strcmp:         ;Função que sera responsavel em corrigir o resultado!
                ; mov si, string1, mov di, string2
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

clearTela:  ;Função responsável por atualizar a tela

    mov ah, 0
    mov al,12h
    int 10h
    ret

print_line:

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop0:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop0 
    
    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy2
    mov dx, [si] ; posicao inicial de y

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy1
    mov dx, [si] ; posicao inicial de y

    .loop1:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop1 
    
    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy2
    mov dx, [si] ; posicao inicial de y

    .loop2:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop2 
    
    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy3
    mov dx, [si] ; posicao inicial de y

    .loop3:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop3 

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy4
    mov dx, [si] ; posicao inicial de y

    .loop4:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop4 

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy5
    mov dx, [si] ; posicao inicial de y

    .loop5:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop5 

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy6
    mov dx, [si] ; posicao inicial de y

    .loop6:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop6 

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy7
    mov dx, [si] ; posicao inicial de y

    .loop7:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop7 

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy8
    mov dx, [si] ; posicao inicial de y

    .loop8:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop8

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy9
    mov dx, [si] ; posicao inicial de y

    .loop9:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc cx      ; cx = cx + 1
        mov ax, cx  ; vamos usar ax como um auxiliar, para ver se a linha ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, lineSize 
        cmp ax, [si]
        jng .loop9 
        ret

print_column:

    mov si, initialPosx1
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop0:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx1
        sub ax, [si]
        mov si, columnSize 
        cmp ax, [si]
        jng .loop0
    
    mov si, initialPosx2
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop1:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx2
        sub ax, [si]
        mov si, columnSize1
        cmp ax, [si]
        jng .loop1
    
    mov si, initialPosx3
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop2:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx3
        sub ax, [si]
        mov si, columnSize2 
        cmp ax, [si]
        jng .loop2
    
    mov si, initialPosx4
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop3:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx4
        sub ax, [si]
        mov si, columnSize3 
        cmp ax, [si]
        jng .loop3
    
    mov si, initialPosx5
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop4:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx5
        sub ax, [si]
        mov si, columnSize4 
        cmp ax, [si]
        jng .loop4
    
    mov si, initialPosx6
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop5:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx6
        sub ax, [si]
        mov si, columnSize5 
        cmp ax, [si]
        jng .loop5
    
    mov si, initialPosx7
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop6:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx7
        sub ax, [si]
        mov si, columnSize6 
        cmp ax, [si]
        jng .loop6
    
    mov si, initialPosx8
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop7:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx8
        sub ax, [si]
        mov si, columnSize7 
        cmp ax, [si]
        jng .loop7
    
    mov si, initialPosx9
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop8:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx9
        sub ax, [si]
        mov si, columnSize8 
        cmp ax, [si]
        jng .loop8
    
    mov si, initialPosx10
    mov cx, [si] ; posicao inicial de x
    mov si, initialPosy0
    mov dx, [si] ; posicao inicial de y

    .loop9:

        mov ah, 0ch ; inicia a configuracao para escrever na tela
        mov al, 0fh ; escolhi a cor branca
        mov bh, 00h ; configura o numero da pagina
        int 10h     ; interrupcao para executar as configuracoes acima

        inc dx      ; dx = dx + 1
        mov ax, dx  ; vamos usar ax como um auxiliar, para ver se a coluna ja foi printada por completo
        mov si, initialPosx10
        sub ax, [si]
        mov si, columnSize9
        cmp ax, [si]
        jng .loop9
        ret
corrigeNumero:

    cmp al, 0
        je .corrige0
    cmp al, 2
        je .corrige1
    cmp al, 4
        je .corrige2
    cmp al, 6
        je .corrige3
    cmp al, 8
        je .corrige4
    cmp al, 10
        je .corrige5
    cmp al, 12
        je .corrige6
    cmp al, 14
        je .corrige7
    cmp al, 16
        je .corrige8

    .corrige0:
        mov al, 0
        ret
    .corrige1:
        mov al, 1
        ret
    .corrige2:
        mov al, 2
        ret
    .corrige3:
        mov al, 3
        ret
    .corrige4:
        mov al, 4
        ret
    .corrige5:
        mov al, 5
        ret
    .corrige6:
        mov al, 6
        ret
    .corrige7:
        mov al, 7
        ret
    .corrige8:
        mov al, 8
        ret


start:
    
    xor ax, ax      ;limpando ax
    mov ds, ax      ;limpando ds
    mov es, ax      ;limpando es

    call menu
    jmp done

menu:   ;Configurações do Menu

    call clearTela  ;Configurando o modo de video

    mov ah, 0bh ; inicia configuracao de background
    mov bh, 00h ; configuracao da cor do background
    mov bl, 09h ; escolhi o azul claro como a cor do background. Ha 16 cores possiveis, de 0 a F (em hexadecimal).
    int 10h     ; interrupcao para executar as configuracoes dessas linhas acima

    ;Colocando string "stringTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl, 0ah   ;Cor da String em bl (verde clara)
	mov dh, 3    ;Linha
	mov dl, 33   ;Coluna
	int 10h 
    mov si, stringTitle
    call prints

    ;Colocando string "stringPlay"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl, whiteColor ; retornando para a cor branca (na string title colocamos a verde)
	mov dh, whiteColor   ;Linha
	mov dl, 32   ;Coluna
	int 10h
    mov si, stringPlay
    call prints

    ;Colocando string "stringHowToPlay"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, 20   ;Linha
	mov dl, 31   ;Coluna
	int 10h
    mov si, stringHowToPlay
    call prints

    ;Colocando string "stringCredits"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, 25   ;Linha
	mov dl, 33   ;Coluna
	int 10h
    mov si, stringCredits
    call prints

    .selecao:

        call getChar

        cmp al, 49      ;Comparando com '1'
        je play

        cmp al, 50      ;Comparando com '2'
        je howToPlay
        
        cmp al, 51      ;Comparando com '3'
        je credits

        jmp .selecao    ;Se não for nenhuma das opções, fica no loop!

play:   ;Aqui ficara toda a lógica do jogo!

    call clearTela  ;Limpa a tela
    mov al, 0   ;Zerando as variaveis antes de iniciar
    mov SI, linhaSudoku 
    mov [esi], al        
    mov SI, colunaSudoku 
    mov [esi], al
            
    mov SI, sudokuBackup ;Copiando o novo jogo...
    mov DI, sudokuPlaying
    call strcpy

    .loop:

        mov ah, 0bh ; inicia configuracao de background
        mov bh, 00h ; configuracao da cor do background
        mov bl, 07h ; escolhi o cinza claro como a cor do background. Ha 16 cores possiveis, de 0 a F (em hexadecimal).
        int 10h     ; interrupcao para executar as configuracoes dessas linhas acima

        ;Colocando string "stringPlayTitle"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, 02h  ;Cor da String em bl
        mov dh, 1    ;Linha
        mov dl, 36   ;Coluna
        int 10h 
        mov si, stringPlayTitle
        call prints

        ;Colocando string "stringEsc"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, 0eh  ;Cor da String em bl
        mov dh, 29   ;Linha
        mov dl, 28   ;Coluna
        int 10h 
        mov si, stringEsc
        call prints

        ;Colocando o sudoku
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov dh, 8    ;Linha
        mov dl, 32   ;Coluna
        int 10h 
        mov SI, sudokuPlaying  
        call printsSudoku

        call print_line
        call print_column

        ;Debugando para saber a linha e a coluna atual!
        call putEndl
        mov bl, whiteColor

        mov SI, msgLinhaAtual  
        call prints
        mov SI, linhaSudoku ;SI ira apontar para o endereço da variavel  
        mov al, [esi]       ;Pegamos o valor o qual o SI está apontando 
        call corrigeNumero
        add al,'0'
        call putChar

        call putEndl

        mov SI, msgColunaAtual  
        call prints
        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        call corrigeNumero
        add al, '0'
        call putChar

        ;Lógica de incrementar e decrementar a linha e a coluna
        call getChar

        cmp al, 'w'
            je .decrementaLinha

        cmp al, 'a'
            je .decrementaColuna

        cmp al, 's'
            je .incrementaLinha

        cmp al, 'd'
            je .incrementaColuna

        ;Lógica de mudar os numeros da matriz!

        cmp al,'1'
            je .mudaMatriz
        cmp al,'2'
            je .mudaMatriz
        cmp al,'3'
            je .mudaMatriz
        cmp al,'4'
            je .mudaMatriz
        cmp al,'5'
            je .mudaMatriz
        cmp al,'6'
            je .mudaMatriz
        cmp al,'7'
            je .mudaMatriz
        cmp al,'8'
            je .mudaMatriz
        cmp al,'9'
            je .mudaMatriz

        cmp al, 27  ;Se ele receber o "Esc" volta para o Menu!
            je menu

        cmp al, 13  ;Se ele receber o "Enter" checa a resposta!
            je .checaResposta
        
        jmp .loop

    .decrementaLinha:

        mov SI, linhaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 0          ;Se já esta no limite não faz nada
            je .loop

        dec al
        dec al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop 

    .decrementaColuna:

        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 0          ;Se já esta no limite não faz nada
            je .loop

        dec al
        dec al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop

    .incrementaLinha:

        mov SI, linhaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 16         ;Se já esta no limite não faz nada
            je .loop

        inc al
        inc al
        mov [esi], al      ; Store a double wosrd in eax into memory
        call clearTela

        jmp .loop

    .incrementaColuna:

        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 16          ;Se já esta no limite não faz nada
            je .loop

        inc al
        inc al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop

    .mudaMatriz:        ;(DH == Linha sudoku e DL == ColunaSudoku )

        mov cl, al      ;Cl ira guardar temporariamente al
        xor edi, edi    ;Zerando o di

        mov SI, linhaSudoku  
        mov dh, [esi]      ; Load a double word from memory into eax
        mov SI, colunaSudoku  
        mov dl, [esi]      ; Load a double word from memory into eax

        mov al, 17           ;Inicio do calculo da posição da matriz!
        mul DH              ; AL = AL * DH
        add al, dl          ;O valor da posição da matriz estara em al!
        mov edi, eax        ;Passando valor de al para o registrador de segmento(como se fosse ponteiro)
        
        ;Irei descobrir se eu posso mudar ou se são os valores padrões!
        mov SI, CanChangeSudoku
        mov dl, [esi + edi]         ;dl ficara com '0' ou '1'
        cmp dl, '0'                 ;Se não pode mudar volta para o loop
            je .cantChange

        mov SI, sudokuPlaying       ;Se for possivel mudar,ele muda a matriz!
        mov [esi + edi], cl
        call clearTela

        jmp .loop
    
    .cantChange:

        ;Colocando string "Cant Change"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, redColor    ;Cor da String em bl
        mov dh, 15    ;Linha
        mov dl, 60   ;Coluna
        int 10h 
        mov si, msgCantChange
        call prints

        jmp .loop

    .checaResposta: ;Checando a vitoria!

        mov SI, sudokuAnswers
        mov DI, sudokuPlaying
        call strcmp
        jc .victory  ;Se for igual ele pula!

        ;Colocando string "Wrong Answer"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, redColor    ;Cor da String em bl
        mov dh, 3    ;Linha
        mov dl, 28   ;Coluna
        int 10h 
        mov si, msgWrongAnswer
        call prints

        jmp .loop

    .victory:

        ;Colocando string "msgVictory"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, greenColor    ;Cor da String em bl
        mov dh, 3    ;Linha
        mov dl, 35   ;Coluna
        int 10h 
        mov si, msgVictory
        call prints

        ;Colocando o sudoku
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov dh, 8    ;Linha
        mov dl, 32   ;Coluna
        int 10h 
        mov SI, sudokuPlaying  
        call printsSudoku

        ;Colocando string "stringEsc"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl,whiteColor    ;Cor da String em bl
        mov dh, 29    ;Linha
        mov dl, 28   ;Coluna
        int 10h 
        mov si, stringEsc
        call prints

        call getChar

        cmp al, 27 ;Apertou o ESC
            je menu

        jmp .victory

howToPlay:  ;Instruções do jogo

    call clearTela  ;Limpa a tela

    mov ah, 0bh ; inicia configuracao de background
    mov bh, 00h ; configuracao da cor do background
    mov bl, 09h ; escolhi o azul claro como a cor do background. Ha 16 cores possiveis, de 0 a F (em hexadecimal).
    int 10h     ; interrupcao para executar as configuracoes dessas linhas acima

    ;Colocando string "stringHowToPlayTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,0ah   ;Cor da String em bl (verde claro)
	mov dh, 3    ;Linha
	mov dl, 34   ;Coluna
	int 10h 
    mov si, stringHowToPlayTitle
    call prints

    ;Colocando string "stringHowToPlay1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 10    ;Linha
	mov dl, 7   ;Coluna
	int 10h 
    mov si, stringHowToPlay1
    call prints

    ;Colocando string "stringHowToPlay2"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 11    ;Linha
	mov dl, 7   ;Coluna
	int 10h 
    mov si, stringHowToPlay2
    call prints

    ;Colocando string "stringHowToPlay3"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 12    ;Linha
	mov dl, 7   ;Coluna
	int 10h 
    mov si, stringHowToPlay3
    call prints

    ;Colocando string "stringHowToPlay4"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 20    ;Linha
	mov dl, 26   ;Coluna
	int 10h 
    mov si, stringHowToPlay4
    call prints

    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl, 0eh    ;Cor amarela
	mov dh, 29    ;Linha
	mov dl, 28   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getChar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

credits:    ;Créditos do jogo

    call clearTela  ;Limpa a tela

    mov ah, 0bh ; inicia configuracao de background
    mov bh, 00h ; configuracao da cor do background
    mov bl, 09h ; escolhi o azul claro como a cor do background. Ha 16 cores possiveis, de 0 a F (em hexadecimal).
    int 10h     ; interrupcao para executar as configuracoes dessas linhas acima

    ;Colocando string "stringCreditsTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl, 0ah  ;Cor da String em bl (verde claro)
	mov dh, 3    ;Linha
	mov dl, 36   ;Coluna
	int 10h 
    mov si, stringCreditsTitle
    call prints

    ;Colocando string "stringCredits1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 12    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits1
    call prints

    ;Colocando string "stringCredits2"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 13    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits2
    call prints
    
    ;Colocando string "stringCredits3"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 14    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits3
    call prints

    ;Colocando string "stringCredits4"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 15    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits4
    call prints
    
    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl, 0eh  ;Cor da String em bl (yellow)
	mov dh, 29   ;Linha
	mov dl, 28   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getChar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

done:

    jmp $

;---------------------------------------------------------------------------------------------------------------------
;Funções que talvez use

clear:  ;Função para limpar a tela                  
 
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
