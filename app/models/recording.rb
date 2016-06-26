class Recording < ApplicationRecord
  belongs_to :song

  attr_accessor :file
end
