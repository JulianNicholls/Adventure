class Monster:
    "Hold a monster"
    
    __state_names = ('dead', 'wounded', 'very much alive')
    
    def __init__( self, name, state = 2 ):
        "Initialise with a name and an optional health state"
        self.__name     = name
        self.__state    = state
        

    def health( self ):
        "Return health state"
        return self.__state
        
        
    def health_desc( self, no_alive = True ):
        "Return the health, optionally with alive"
        if not no_alive or self.__state < 2:
            return Monster.__state_names[self.__state]
        else:
            return ''
        
        
    def name( self ):
        "Return monster name"
        return self.__name
        
        
    def attack( self ):
        "Attack the monster, killing it if it's wounded"
        self.__state = max( self.__state - 1, 0 )
        
        
    def kill( self ):
        "Kill it"
        self.__state = 0
