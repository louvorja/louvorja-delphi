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

## Requisitos

Você vai precisar de:

- Delphi RAD Studio 10.2 ([baixe aqui](https://altd.embarcadero.com/download/radstudio/10.2/delphicbuilder10_2.iso))
- Uma versão instalada (e preferencialmente sincronizada) do LouvorJA ([baixe aqui](https://louvorja.com.br/download/)) em uma pasta de desenvolvimento.
- Um computador com Windows

## Instalação dos componentes

Você vai precisar instalar alguns componentes. Para isso, siga as instruções abaixo, ou [clique aqui](https://delphidabbler.com/install-to-ide) para acessar uma documentação mais detalhada sobre a instalação de componentes no Delphi.

### CnWizards

Instação opcional. Serve para deixar o código com uma aparência mais organizada. Navegue até a pasta `/components/CnWizards`, e execute o arquivo ".exe" dentro dela.

### BusinessSkinForm

#### Instalação

1. Abra o RAD Studio e no menu "File", selecione "Open".
2. Navegue até a pasta `/components/bsfd102tokyo` deste repositório e selecione o arquivo `bsfd102Tokyo.dpk`.
3. O pacote será exibido em seu Project Manager (normalmente a porção direita da tela) sob o nome `bsfd102Tokyo.bpl`. Clique com o botão direito nesse projeto e clique em "Install".
4. Após instalado, pode fechar o projeto.

#### Adicionando o Caminho

1. Vá para o menu "Tools" na parte superior da janela da IDE.
2. Selecione "Options" no menu suspenso.
3. Na janela de opções, no painel esquerdo, expanda a seção "Environment Options".
4. Clique em "Delphi Options" para expandir ainda mais as opções.
5. Selecione a opção "Library".
6. No lado direito da janela, você verá a seção "Library path". Clique no botão "..." à direita da caixa de edição.
7. Na janela de edição de diretório, clique no ícone da pastinha, navegue até o diretório do componente `/components/bsfd102tokyo`, e clique em "Selecionar Pasta".
8. Clique em "Add", e em seguida, em "Ok".

### PNGComponents

1. Abra o RAD Studio e no menu "File", selecione "Open".
2. Navegue até a pasta `/components/PNGComponents/Packages/Tokyo/Delphi` deste repositório e selecione o arquivo `PngComponentsDDesign.dpk`.
3. O pacote será exibido em seu Project Manager (normalmente a porção direita da tela) sob o nome `PngComponentsDDesign250.bpl`. Clique com o botão direito nesse projeto e clique em "Install".
4. Após instalado, pode fechar o projeto.

## Execução do Programa

### Altere a pasta de build do projeto

1. No RAD Studio, selecione o menu File > Open e abra o arquivo "LouvorJA.dproj" deste repositório.
2. No menu superior Project, selecione "Options..."
3. Na aba "Delphi Compiler", selecione a opção "Output directory" (não é necessário expandir a opção) e selecione a pasta onde está o executável do programa, copiado para o diretório de desenvolvimento, conforme seção "Requisitos".

---

Após seguir esses passos, você provavelmente já conseguirá executar o LouvorJA no modo de desenvolvedor, a partir do código, em sua máquina, e trabalhar em melhorias. Esses passos foram desenvolvidos para se executar na versão 10.2 (Tokyo) do Delphi, e podem não funcionar em outras versões, por mais atualizadas que sejam.
