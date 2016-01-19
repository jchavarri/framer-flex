bg = new BackgroundLayer
    backgroundColor: "#eee"

class MainContainer extends Layer
    
    constructor: (options = {}) ->
        super options
        @name = "mainContainer"
        @backgroundColor = "#f3f6f8"
        @flex = 1
        @padding = 10
        @_buildDescendants()

    _changeDirection: (contentDirection) =>
        @emit("action:changeDirection", contentDirection)
    
    _buildDescendants: ->
        @addChild new Header 
            actionChangeDirection: @_changeDirection
        @addChild new Content
            emitter: @
        @addChild new Footer

class Header extends Layer
    
    constructor: (options = {}) ->
        super options
        @backgroundColor = "#d54e21"
        @name = "headerLayer"
        @borderRadius = 4
        @flex = 0.1
        @flexDirection = "row"
        @minHeight = 30
        @alignItems = "center"
        @justifyContent = "center"
        @flexDirectionAction = options.actionChangeDirection
        @_buildDescendants()

        # This variable will set the content direction
        @contentDirection = "row"
    
    _buildDescendants: ->
        titleLayer = new Layer
            superLayer: @
            minWidth: 400
            flex: 0.9
            marginLeft: 100
            fixedHeight: 30
            backgroundColor: ""
            html: "FramerFlex™"
        titleLayer.style.textAlign = "center"
        titleLayer.style.lineHeight = titleLayer.fixedHeight + "px"
        titleLayer.style.fontSize = "24px"
        titleLayer.style.fontWeight = "600"

        flexDirectionButton = new Layer
            superLayer: @
            minWidth: 120
            marginRight: 10
            fixedHeight: 30
            backgroundColor: "#f0b849"
            borderRadius: 4
            html: "Order by column"
        flexDirectionButton.style.textAlign = "center"
        flexDirectionButton.style.lineHeight = flexDirectionButton.fixedHeight + "px"
        flexDirectionButton.style.fontSize = "14px"
        flexDirectionButton.style.fontWeight = "400"
        flexDirectionButton.on Events.Click, =>
            flexDirectionButton.html = "Order by " + @contentDirection
            @contentDirection = if (@contentDirection is "row") then "column" else "row"
            @flexDirectionAction(@contentDirection)

class Content extends Layer
    
    constructor: (options = {}) ->
        super options
        @backgroundColor = "#a8bece"
        @name = "contentLayer"
        @marginTop = 10
        @marginBottom = 10
        @borderRadius = 4
        @flex = 0.9
        @flexDirection = "row"
        @flexWrap = "wrap"
        @paddingRight = 10
        
        options.emitter.on "action:changeDirection", (contentDirection) =>
            @flexDirection = contentDirection

        @_buildDescendants()

    _buildDescendants: ->

        for cellIndex in [0...20]

            cell = new Layer
                superLayer: @
                borderRadius: 2
                backgroundColor: "#fff"
                marginLeft: 10
                marginTop: 10
                fixedWidth: 100
                fixedHeight: 100
                html: cellIndex

            cell.layout.curve = "spring(300, 40, 10)"
            cell.on Events.Click, (event, layer) ->
                layer.fixedHeight = 160
                layer.fixedWidth = 160

            cell.style.textAlign = "center"
            cell.style.lineHeight = cell.fixedHeight + "px"
            cell.style.fontSize = "34px"
            cell.style.color = "#f0821e"
            cell.style.fontWeight = "600"
    
class Footer extends Layer
    
    constructor: (options = {}) ->
        super options
        @backgroundColor = "#2e4453"
        @name = "contentLayer"
        @borderRadius = 4
        @flex = 0.1


main = new MainContainer