class ConditionEntry
  include Mongoid::Document
  embedded_in :condition
  field :name, type: String
  field :value, type: String
  field :operator, type: String
end
