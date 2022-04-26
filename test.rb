#### --- DEFINITION DE LA METHODE
def methode_sans_argument
  return "Hello World"
end

def methode_avec_un_argument (argument)
  return "Tu m'as donné l'argument #{argument} en entrée."
end

def methode_avec_plusieurs_arguments (argument_1,argument_2)
  return "Tu m'as donné l'argument #{argument_1} et l'argument #{argument_2} en entrée."
end

##### --- APPEL DE LA METHODE
variable_exterieur_1 =
variable_exterieur_2 =
#puts methode_sans_argument()
#puts methode_avec_un_argument(12345)