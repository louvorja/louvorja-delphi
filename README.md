# LouvorJA

Software de projeção de letras de músicas com centenas de músicas do Hinário Adventista, CDs jovens e coletâneas diversas.

[Site oficial](https://louvorja.com.br/)

Alguns dos recursos são:

- Projeção de versículos da bíblia
- Músicas cantadas, playbacks (sem vocal) ou projeção silenciosa (sem áudio)
- Tela de retorno (stage display) com prévia do slide seguinte
- Organizador de liturgia, agendamentos de cultos e cronômetros
- Saída em HTML para transmissão ao vivo (para inclusão no OBS ou Vmix, por exemplo)
- Editor de slides
- Utilitários gerais (sorteador, relógio, painel de recados)

# Como compilar

Você vai precisar de:

- Delphi RAD Studio 10.2 ([baixe aqui](https://altd.embarcadero.com/download/radstudio/10.2/delphicbuilder10_2.iso))
- Uma versão instalada (e preferencialmente sincronizada) do LouvorJA ([baixe aqui](https://louvorja.com.br/download/))
- Um computador com Windows

### Posicionando a biblioteca BASS

Este projeto utiliza a biblioteca [BASS](https://www.un4seen.com/) para manipular e executar arquivos de áudio.

1. Extraia (ou clone) esse repositório na pasta recomendada: `%HOMEDRIVE%%HOMEPATH\Documents\GitHub\louvorja-delphi`. Lembre-se que `%HOMEDRIVE%` indica a letra do disco que você utiliza (normalmente `C:`) e `%HOMEPATH%` indica a pasta de seu usuário (normalmente `\Users\seu_usuario`). Logo, essa pasta normalmente seria `C:\Users\seu_usuario\Documents\GitHub\louvorja-delphi`.

2. Em sua pasta Downloads (normalmente `C:\Users\seu_usuario\Downloads`) crie uma pasta chamada "Delphi". Dentro desta, crie outra pasta, chamada "Componentes". Dentro dessa última, cole a pasta "bass24", disponível na pasta "components" deste repositório.

### Instale os componentes necessários

Você vai precisar instalar o BusinessSkinForm. Para isso, siga as instruções abaixo, ou [clique aqui](https://delphidabbler.com/install-to-ide) para acessar uma documentação mais detalhada sobre a instalação de componentes no Delphi.

1. Abra o RAD Studio e no menu File, selecione Open.
2. Navegue até a pasta `components/bsfd102tokyo` deste repositório e selecione o arquivo `bsfd102Tokyo.dpk`.
3. O pacote será exibido em seu Project Manager (normalmente a porção direita da tela) sob o nome `bsfd102Tokyo.bpl`. Clique com o botão direito nesse projeto e clique em Install.
4. Novamente, clique com o botão direito em `bsfd102Tokyo.bpl` no Project Manager e selecione "Add".
5. Selecione todos os arquivos com extensão `.pas` da pasta `components/bsfd102tokyo` e confirme. Todos os itens selecionados deverão aparecer na seção "Contains" do projeto no Project Manager.
6. Mais uma vez, clique com o botão direito em `bsfd102Tokyo.bpl` e clique em "Compile".
7. Por último, repita o passo 3 para reinstalar o pacote e feche o projeto (File > Close).

### Altere a pasta de build do projeto

1. Crie uma pasta que será seu ambiente de testes do LouvorJA (exemplo: `C:\Users\seu_usuario\Documents\louvorja_test`)
2. No RAD Studio, selecione o menu File > Open e abra o arquivo "LouvorJA.dproj" deste repositório.
3. No menu superior Project, selecione "Options..."
4. Na aba "Delphi Compiler", selecione a opção "Output directory" (não é necessário expandir a opção) e selecione a pasta criada no passo 1.

### Copie os dados sincronizados de sua instalação do LouvorJA

1. Abra a pasta de instalação do LouvorJA (normalmente `C:\Program files (x86)\Louvor JA`)
2. Selecione todos os arquivos ".dll" e a pasta "config", exceto os arquivos "LouvorJA.exe", "unins000.dat" e "unins000.exe" e copie-os para a pasta de testes criada nas etapas da seção anterior (exemplo: `C:\Users\seu_usuario\Documents\louvorja_test`).

---

Após seguir esses passos, você provavelmente já conseguirá executar o LouvorJA no modo de desenvolvedor, a partir do código, em sua máquina, e trabalhar em melhorias. Esses passos foram desenvolvidos para se executar na versão 10.2 (Tokyo) do Delphi, e podem não funcionar em outras versões, por mais atualizadas que sejam.
