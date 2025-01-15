#In this example, the magic_animals_list variable is defined as a list of strings representing magic animals. The resulting list will be ["unicorn", "dragon", "phoenix", "griffin"].

variable "magic_animals_list" {
  type    = list(string)
  default = ["unicorn", "dragon", "phoenix", "griffin", "thestral", "dog"]
}

#In this example, the magic_animals variable is a list of objects. Each object represents a magic animal and contains attributes such as name, power, element, and description. The default value provides a list of four magic animals with their respective attributes.

variable "magic_animals" {
  type = list(object({
    name        = string
    power       = string
    element     = string
    description = string
  }))
  default = [
    {
      name        = "unicorn-update"
      power       = "sparkle"
      element     = "light"
      description = "A mystical creature with a single horn on its forehead."
    },
    {
      name        = "dragon"
      power       = "fire"
      element     = "fire"
      description = "A powerful creature with the ability to breathe fire."
    },
    {
      name        = "phoenix"
      power       = "rebirth"
      element     = "fire"
      description = "A legendary bird that is reborn from its own ashes."
    },
    {
      name        = "griffin"
      power       = "majesty"
      element     = "air"
      description = "A majestic creature with the body of a lion and the head of an eagle."
    }
  ]
}

#In this example, the magic_animals_set variable is defined as a set of strings representing magic animals. The resulting set will be ["unicorn", "dragon", "phoenix", "griffin"]

variable "magic_animals_set" {
  type      = set(string)
  sensitive = true
  #default = ["unicorn", "dragon", "phoenix", "griffin", "black cat"]
}

#In this example, the magic_animals_map variable is defined as a map of strings representing magic animals and their associated qualities. The resulting map will be { "unicorn" = "sparkle", "dragon" = "fire", "phoenix" = "rebirth", "griffin" = "majesty" }.

variable "magic_animals_map" {
  type = map(string)
  default = {
    unicorn = "none"
    dragon  = "sleep"
    phoenix = "eat"
    griffin = "none"
  }
}

#In this example, the magic_animal_object variable is defined as an object with three attributes: name, element, and power. The resulting object will be { "name" = "Mermaid", "element" = "Water", "power" = "Enchanting Voice" }.

variable "magic_animal_object" {
  type = object({
    name    = string
    element = string
    power   = string
  })
  default = {
    name    = "MODULE VERSION Small Mermaid"
    element = "Water"
    power   = "Enchanting Voice"
  }
}

#In this example, the magic_animal_tuple variable is defined as a tuple that contains three magical animal attributes: name, element, and power. The resulting tuple will be ["Centaur", "Earth", "Archery"].

variable "magic_animal_tuple" {
  type = tuple([string, string, string])
  #default = ["Usual Centaur", "Big Earth", "Non-Archery-Dry-check-on-222staging"]
}

variable "magic_animals_string" {
  type    = string
  default = "penguin"
}

variable "magic_animals_number" {
  type    = number
  default = 1
}

variable "magic_animals_bool" {
  type    = bool
  default = true
}
