#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC003

Cadastro MVC de Tabela de Tipos de Chamados

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC003()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de Tipos de Chamados") 
oBrw:SetAlias("ZZC")

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZZC  := FwFormStruct(1,"ZZC")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC003_M")

// Adiciona ao modelo um componente de formul�rio
oModel:AddFields("ZZCMASTER",/*cOwner*/,oStruZZC)

// Adiciona a descri��o do Modelo de Dados 
oModel:SetDescription("Cadastro de Tipos de Chamados")

// Adiciona a descri��o do Componente do Modelo de Dados
oModel:GetModel("ZZCMASTER" ):SetDescription("Cadastro de Tipos de Chamados")

// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Rog�rio O Candisani 
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC003")

// Cria a estrutura a ser usada na View 
Local oStruZZC := FwFormStruct(2,"ZZC")

// Interface de visualiza��o constru�da 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados ser� utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formul�rio  
// (antiga Enchoice
oView:AddField("VIEW_ZZC",oStruZZC,"ZZCMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibi��o 
oView:SetOwnerView( 'VIEW_ZZC', 'TELA' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Rog�rio O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Return FWMVCMenu( "MVC003" )