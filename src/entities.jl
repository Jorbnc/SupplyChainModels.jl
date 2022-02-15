# structs can't be modified once defined
# UNLESS we put them inside a module block and rerun the module definition
# Basically, running the whole again module resets it

module entities

abstract type Company end

struct Supplier <: Company
    name::String
end

struct Manufacturer <: Company
    name::String
end

end