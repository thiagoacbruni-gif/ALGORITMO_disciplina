algoritmo "UniLibrary"
// =====================================================
// UNILIBRARY - SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
// Desafio 1 - Logica de Programacao - Tema 4
// =====================================================

const
   MAX_LIVROS = 50
   NUM_CATEGORIAS = 5
   ANO_ATUAL = 2026
   COL_EMPRESTIMO = 1
   COL_DEVOLUCAO = 2

tipo
   TLivro = registro
      codigo: inteiro
      titulo: caracter
      autor: caracter
      ano: inteiro
      categoria: inteiro
      qtdTotal: inteiro
      qtdDisponivel: inteiro
      qtdEmprestimos: inteiro
      status: caracter
   fimregistro

var
   acervo: vetor[1..50] de TLivro
   copiaSeguranca: vetor[1..50] de TLivro
   qtdLivros: inteiro
   movimentacoes: vetor[1..NUM_CATEGORIAS, 1..2] de inteiro
   nomesCategorias: vetor[1..NUM_CATEGORIAS] de caracter
   opcao: inteiro

// ---------------------------------------------------------
// PROCEDIMENTO: inicializar
// ---------------------------------------------------------
procedimento inicializar()
var
   i, j: inteiro
inicio
   qtdLivros <- 0

   para i de 1 ate NUM_CATEGORIAS faca
      para j de 1 ate 2 faca
         movimentacoes[i, j] <- 0
      fimpara
   fimpara

   nomesCategorias[1] <- "Tecnologia"
   nomesCategorias[2] <- "Ciencias Exatas"
   nomesCategorias[3] <- "Ciencias Humanas"
   nomesCategorias[4] <- "Administracao e Negocios"
   nomesCategorias[5] <- "Literatura"
fimprocedimento

// ---------------------------------------------------------
// FUNCAO: categoriaValida
// ---------------------------------------------------------
funcao categoriaValida(cat: inteiro): logico
var
   res: logico
inicio
   se (cat >= 1) e (cat <= NUM_CATEGORIAS) entao
      res <- verdadeiro
   senao
      res <- falso
   fimse
   retorne res
fimfuncao

// ---------------------------------------------------------
// FUNCAO: anoValido
// ---------------------------------------------------------
funcao anoValido(anoPub: inteiro): logico
var
   res: logico
inicio
   se (anoPub >= 1900) e (anoPub <= ANO_ATUAL) entao
      res <- verdadeiro
   senao
      res <- falso
   fimse
   retorne res
fimfuncao

// ---------------------------------------------------------
// FUNCAO: codigoExiste
// ---------------------------------------------------------
funcao codigoExiste(codBusca: inteiro): logico
var
   i: inteiro
   achou: logico
inicio
   achou <- falso
   para i de 1 ate qtdLivros faca
      se acervo[i].codigo = codBusca entao
         achou <- verdadeiro
      fimse
   fimpara
   retorne achou
fimfuncao

// ---------------------------------------------------------
// FUNCAO: localizarLivro
// ---------------------------------------------------------
funcao localizarLivro(codBusca: inteiro): inteiro
var
   i, p: inteiro
inicio
   p <- -1
   para i de 1 ate qtdLivros faca
      se acervo[i].codigo = codBusca entao
         p <- i
      fimse
   fimpara
   retorne p
fimfuncao

// ---------------------------------------------------------
// PROCEDIMENTO: exibirCategorias
// ---------------------------------------------------------
procedimento exibirCategorias()
var
   i: inteiro
inicio
   para i de 1 ate NUM_CATEGORIAS faca
      escreval(i, " - ", nomesCategorias[i])
   fimpara
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: cadastrarLivro
// ---------------------------------------------------------
procedimento cadastrarLivro()
var
   novoCodigo, novoAno, novaCategoria, novaQtd: inteiro
   novoTitulo, novoAutor: caracter
   codigoOk, anoOk, categoriaOk, qtdOk: logico
inicio
   se qtdLivros >= MAX_LIVROS entao
      escreval("ERRO: capacidade maxima do acervo atingida.")
   senao
      codigoOk <- falso
      enquanto nao codigoOk faca
         escreva("Codigo do livro: ")
         leia(novoCodigo)
         se codigoExiste(novoCodigo) entao
            escreval("ERRO: codigo ja cadastrado. Informe outro.")
         senao
            codigoOk <- verdadeiro
         fimse
      fimenquanto

      escreva("Titulo: ")
      leia(novoTitulo)

      escreva("Autor: ")
      leia(novoAutor)

      anoOk <- falso
      enquanto nao anoOk faca
         escreva("Ano de publicacao: ")
         leia(novoAno)
         se anoValido(novoAno) entao
            anoOk <- verdadeiro
         senao
            escreval("ERRO: ano invalido. Tente novamente.")
         fimse
      fimenquanto

      categoriaOk <- falso
      enquanto nao categoriaOk faca
         escreval("Categorias disponiveis:")
         exibirCategorias()
         escreva("Categoria: ")
         leia(novaCategoria)
         se categoriaValida(novaCategoria) entao
            categoriaOk <- verdadeiro
         senao
            escreval("ERRO: categoria invalida. Tente novamente.")
         fimse
      fimenquanto

      qtdOk <- falso
      enquanto nao qtdOk faca
         escreva("Quantidade de exemplares: ")
         leia(novaQtd)
         se novaQtd <= 0 entao
            escreval("ERRO: quantidade invalida. Tente novamente.")
         senao
            qtdOk <- verdadeiro
         fimse
      fimenquanto

      qtdLivros <- qtdLivros + 1
      acervo[qtdLivros].codigo <- novoCodigo
      acervo[qtdLivros].titulo <- novoTitulo
      acervo[qtdLivros].autor <- novoAutor
      acervo[qtdLivros].ano <- novoAno
      acervo[qtdLivros].categoria <- novaCategoria
      acervo[qtdLivros].qtdTotal <- novaQtd
      acervo[qtdLivros].qtdDisponivel <- novaQtd
      acervo[qtdLivros].qtdEmprestimos <- 0
      acervo[qtdLivros].status <- "DISPONIVEL"

      escreval("Livro cadastrado com sucesso!")
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: exibirDadosLivro
// ---------------------------------------------------------
procedimento exibirDadosLivro(posicao: inteiro)
inicio
   escreval("Codigo..............: ", acervo[posicao].codigo)
   escreval("Titulo..............: ", acervo[posicao].titulo)
   escreval("Autor...............: ", acervo[posicao].autor)
   escreval("Ano.................: ", acervo[posicao].ano)
   escreval("Categoria...........: ", nomesCategorias[acervo[posicao].categoria])
   escreval("Qtd. Total..........: ", acervo[posicao].qtdTotal)
   escreval("Qtd. Disponivel.....: ", acervo[posicao].qtdDisponivel)
   escreval("Qtd. Emprestimos....: ", acervo[posicao].qtdEmprestimos)
   escreval("Status..............: ", acervo[posicao].status)
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: listarAcervo
// ---------------------------------------------------------
procedimento listarAcervo()
var
   i: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao ha livros cadastrados.")
   senao
      para i de 1 ate qtdLivros faca
         escreval("------------------------------------")
         exibirDadosLivro(i)
      fimpara
      escreval("------------------------------------")
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: consultarLivro
// ---------------------------------------------------------
procedimento consultarLivro()
var
   codigo, posicao: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao ha livros cadastrados.")
   senao
      escreva("Informe o codigo do livro: ")
      leia(codigo)
      posicao <- localizarLivro(codigo)
      se posicao = -1 entao
         escreval("Livro nao encontrado.")
      senao
         exibirDadosLivro(posicao)
      fimse
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: realizarEmprestimo
// ---------------------------------------------------------
procedimento realizarEmprestimo()
var
   codigo, posicao, cat: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao e possivel realizar emprestimo.")
   senao
      escreva("Codigo do livro: ")
      leia(codigo)
      posicao <- localizarLivro(codigo)

      se posicao = -1 entao
         escreval("ERRO: livro nao encontrado.")
      senao
         se acervo[posicao].qtdDisponivel <= 0 entao
            escreval("ERRO: nao ha exemplares disponiveis para emprestimo.")
         senao
            acervo[posicao].qtdDisponivel <- acervo[posicao].qtdDisponivel - 1
            acervo[posicao].qtdEmprestimos <- acervo[posicao].qtdEmprestimos + 1

            cat <- acervo[posicao].categoria
            movimentacoes[cat, COL_EMPRESTIMO] <- movimentacoes[cat, COL_EMPRESTIMO] + 1

            se acervo[posicao].qtdDisponivel = 0 entao
               acervo[posicao].status <- "INDISPONIVEL"
            fimse

            escreval("Emprestimo realizado com sucesso!")
         fimse
      fimse
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: realizarDevolucao
// ---------------------------------------------------------
procedimento realizarDevolucao()
var
   codigo, posicao, cat, qtdEmprestada: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao e possivel realizar devolucao.")
   senao
      escreva("Codigo do livro: ")
      leia(codigo)
      posicao <- localizarLivro(codigo)

      se posicao = -1 entao
         escreval("ERRO: livro nao encontrado.")
      senao
         qtdEmprestada <- acervo[posicao].qtdTotal - acervo[posicao].qtdDisponivel

         se qtdEmprestada <= 0 entao
            escreval("ERRO: todos os exemplares ja estao disponiveis.")
         senao
            acervo[posicao].qtdDisponivel <- acervo[posicao].qtdDisponivel + 1
            acervo[posicao].status <- "DISPONIVEL"

            cat <- acervo[posicao].categoria
            movimentacoes[cat, COL_DEVOLUCAO] <- movimentacoes[cat, COL_DEVOLUCAO] + 1

            escreval("Devolucao realizada com sucesso!")
         fimse
      fimse
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: exibirDisponiveis
// ---------------------------------------------------------
procedimento exibirDisponiveis()
var
   i: inteiro
   existeDisponivel: logico
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio.")
   senao
      existeDisponivel <- falso
      para i de 1 ate qtdLivros faca
         se acervo[i].qtdDisponivel > 0 entao
            escreval("------------------------------------")
            exibirDadosLivro(i)
            existeDisponivel <- verdadeiro
         fimse
      fimpara
      se nao existeDisponivel entao
         escreval("Nenhum livro disponivel no momento.")
      fimse
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: ordenarPorEmprestimos (Linha corrigida)
// ---------------------------------------------------------
procedimento ordenarPorEmprestimos(qtd: inteiro)
var
   i, j: inteiro
   aux: TLivro
inicio
   para i de 1 ate qtd - 1 faca
      para j de 1 ate qtd - i faca
         se (copiaSeguranca[j].qtdEmprestimos < copiaSeguranca[j+1].qtdEmprestimos) entao
            aux <- copiaSeguranca[j]
            copiaSeguranca[j] <- copiaSeguranca[j+1]
            copiaSeguranca[j+1] <- aux
         senao
            se (copiaSeguranca[j].qtdEmprestimos = copiaSeguranca[j+1].qtdEmprestimos) e (copiaSeguranca[j].titulo > copiaSeguranca[j+1].titulo) entao
               aux <- copiaSeguranca[j]
               copiaSeguranca[j] <- copiaSeguranca[j+1]
               copiaSeguranca[j+1] <- aux
            fimse
         fimse
      fimpara
   fimpara
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: exibirRanking
// ---------------------------------------------------------
procedimento exibirRanking()
var
   i: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio.")
   senao
      para i de 1 ate qtdLivros faca
         copiaSeguranca[i] <- acervo[i]
      fimpara

      ordenarPorEmprestimos(qtdLivros)

      escreval("=== RANKING DO ACERVO (por emprestimos) ===")
      para i de 1 ate qtdLivros faca
         escreval(i, "o - ", copiaSeguranca[i].titulo, " | Emprestimos: ", copiaSeguranca[i].qtdEmprestimos)
      fimpara
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: exibirEstatisticas
// ---------------------------------------------------------
procedimento exibirEstatisticas()
var
   i, j, totalMovimentacoes: inteiro
   totalExemplares, totalDisponiveis, totalEmprestados: inteiro
   posMaiorEmprestimo, posMaiorDisponivel: inteiro
   media: real
   livrosPorCategoria: vetor[1..NUM_CATEGORIAS] de inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao ha estatisticas para exibir.")
   senao
      totalMovimentacoes <- 0
      escreval("=== MOVIMENTACOES POR CATEGORIA ===")
      escreval("CATEGORIA                     | EMPRESTIMOS | DEVOLUCOES")
      para i de 1 ate NUM_CATEGORIAS faca
         escreval(nomesCategorias[i], " | ", movimentacoes[i, COL_EMPRESTIMO], " | ", movimentacoes[i, COL_DEVOLUCAO])
         para j de 1 ate 2 faca
            totalMovimentacoes <- totalMovimentacoes + movimentacoes[i, j]
         fimpara
      fimpara
      escreval("Total de movimentacoes registradas: ", totalMovimentacoes)

      totalExemplares <- 0
      totalDisponiveis <- 0
      totalEmprestados <- 0
      posMaiorEmprestimo <- 1
      posMaiorDisponivel <- 1

      para i de 1 ate NUM_CATEGORIAS faca
         livrosPorCategoria[i] <- 0
      fimpara

      para i de 1 ate qtdLivros faca
         totalExemplares <- totalExemplares + acervo[i].qtdTotal
         totalDisponiveis <- totalDisponiveis + acervo[i].qtdDisponivel
         totalEmprestados <- totalEmprestados + (acervo[i].qtdTotal - acervo[i].qtdDisponivel)

         livrosPorCategoria[acervo[i].categoria] <- livrosPorCategoria[acervo[i].categoria] + 1

         se acervo[i].qtdEmprestimos > acervo[posMaiorEmprestimo].qtdEmprestimos entao
            posMaiorEmprestimo <- i
         fimse

         se acervo[i].qtdDisponivel > acervo[posMaiorDisponivel].qtdDisponivel entao
            posMaiorDisponivel <- i
         fimse
      fimpara

      media <- totalExemplares / qtdLivros

      escreval("")
      escreval("=== ESTATISTICAS GERAIS ===")
      escreval("Total de livros cadastrados.....: ", qtdLivros)
      escreval("Total de exemplares..............: ", totalExemplares)
      escreval("Total disponivel..................: ", totalDisponiveis)
      escreval("Total emprestado...................: ", totalEmprestados)
      escreval("Media de exemplares por livro.......: ", media)
      escreval("Livro mais emprestado...............: ", acervo[posMaiorEmprestimo].titulo, " (", acervo[posMaiorEmprestimo].qtdEmprestimos, " emprestimos)")
      escreval("Livro com maior disponibilidade.....: ", acervo[posMaiorDisponivel].titulo, " (", acervo[posMaiorDisponivel].qtdDisponivel, " disponiveis)")

      escreval("")
      escreval("=== LIVROS POR CATEGORIA ===")
      para i de 1 ate NUM_CATEGORIAS faca
         escreval(nomesCategorias[i], ": ", livrosPorCategoria[i])
      fimpara
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: ordenarPorCodigo
// ---------------------------------------------------------
procedimento ordenarPorCodigo(qtd: inteiro)
var
   i, j: inteiro
   aux: TLivro
inicio
   para i de 1 ate qtd - 1 faca
      para j de 1 ate qtd - i faca
         se copiaSeguranca[j].codigo > copiaSeguranca[j+1].codigo entao
            aux <- copiaSeguranca[j]
            copiaSeguranca[j] <- copiaSeguranca[j+1]
            copiaSeguranca[j+1] <- aux
         fimse
      fimpara
   fimpara
fimprocedimento

// ---------------------------------------------------------
// FUNCAO: buscaBinaria
// ---------------------------------------------------------
funcao buscaBinaria(codBusca: inteiro): inteiro
var
   posIni, posFim, meio, resultado: inteiro
inicio
   posIni <- 1
   posFim <- qtdLivros
   resultado <- -1

   enquanto posIni <= posFim faca
      meio <- (posIni + posFim) div 2

      se copiaSeguranca[meio].codigo = codBusca entao
         resultado <- meio
         posIni <- posFim + 1
      senao
         se codBusca < copiaSeguranca[meio].codigo entao
            posFim <- meio - 1
         senao
            posIni <- meio + 1
         fimse
      fimse
   fimenquanto

   retorne resultado
fimfuncao

// ---------------------------------------------------------
// PROCEDIMENTO: realizarBuscaBinaria
// ---------------------------------------------------------
procedimento realizarBuscaBinaria()
var
   i, codigo, resultadoPos: inteiro
inicio
   se qtdLivros = 0 entao
      escreval("Catalogo vazio. Nao e possivel realizar busca.")
   senao
      para i de 1 ate qtdLivros faca
         copiaSeguranca[i] <- acervo[i]
      fimpara

      ordenarPorCodigo(qtdLivros)

      escreva("Informe o codigo a ser pesquisado: ")
      leia(codigo)

      resultadoPos <- buscaBinaria(codigo)

      se resultadoPos = -1 entao
         escreval("Livro nao encontrado no catalogo.")
      senao
         escreval("Livro encontrado!")
         escreval("Titulo: ", copiaSeguranca[resultadoPos].titulo)
         escreval("Autor.: ", copiaSeguranca[resultadoPos].autor)
         escreval("Status: ", copiaSeguranca[resultadoPos].status)
      fimse
   fimse
fimprocedimento

// ---------------------------------------------------------
// PROCEDIMENTO: exibirMenu
// ---------------------------------------------------------
procedimento exibirMenu()
inicio
   escreval("")
   escreval("====================================================")
   escreval("       UNILIBRARY - SISTEMA DE GERENCIAMENTO")
   escreval("====================================================")
   escreval("1 - Cadastrar livro")
   escreval("2 - Listar acervo")
   escreval("3 - Consultar livro")
   escreval("4 - Realizar emprestimo")
   escreval("5 - Realizar devolucao")
   escreval("6 - Exibir livros disponiveis")
   escreval("7 - Exibir ranking do acervo")
   escreval("8 - Exibir estatisticas")
   escreval("9 - Realizar busca no acervo")
   escreval("10 - Encerrar sistema")
   escreval("====================================================")
fimprocedimento

// =====================================================
// PROGRAMA PRINCIPAL
// =====================================================
inicio
   inicializar()

   repita
      exibirMenu()
      escreva("Escolha uma opcao: ")
      leia(opcao)

      escolha opcao
         caso 1
            cadastrarLivro()
         caso 2
            listarAcervo()
         caso 3
            consultarLivro()
         caso 4
            realizarEmprestimo()
         caso 5
            realizarDevolucao()
         caso 6
            exibirDisponiveis()
         caso 7
            exibirRanking()
         caso 8
            exibirEstatisticas()
         caso 9
            realizarBuscaBinaria()
         caso 10
            escreval("Encerrando o sistema. Ate logo!")
         outrocaso
            escreval("ERRO: opcao invalida. Tente novamente.")
      fimescolha

   ate opcao = 10

fimalgoritmo