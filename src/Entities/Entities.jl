module entities

abstract type Company end

struct Supplier <: Company
    name::String
end

struct Manufacturer <: Company
    name::String
end

struct Customer <: Company
    name::String
end

end # Module entities