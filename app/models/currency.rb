class Currency < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  belongs_to :country

  def self.collected
    all.select {|currency| currency.collected? }
  end

  def self.not_collected
    all.reject {|currency| currency.collected? }
  end

  def collected?
    country.nil? ? false : country.visited?
  end



def self.search(search)
  if search
    where('name LIKE ?', "%#{search}%")
  else
    scoped
  end
end



end
