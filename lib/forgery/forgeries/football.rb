class Forgery::Football < Forgery
  def self.position
    dictionaries[:positions].random.unextend
  end
end