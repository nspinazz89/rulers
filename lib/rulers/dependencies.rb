# rulers/lib/rulers/dependencies.rb

class Object
  def self.const_missing(c)
    # this isn't going to cut it longterm if there is a multi-thread issue, but resolves stack too deep const_missing
    return nil if @calling_const_missing

    @calling_const_missing = true
    require Rulers.to_underscore(c.to_s)
    klass = Object.const_get(c)
    @calling_const_missing = false

    klass
  end
end