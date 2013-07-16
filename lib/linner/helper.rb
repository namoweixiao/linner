module Linner
  module HashRecursiveMerge
    def rmerge!(other_hash)
      merge!(other_hash) do |key, oldval, newval|
        oldval.class == self.class ? oldval.rmerge!(newval) : newval
      end
    end
  end

  module Sort
    def sort_by_before_and_after(before, after)
      sort_by_before(self, before)
      sort_by_after(self, after)
      self
    end

    private
    def sort_by_before(list, before)
      before.reverse.each do |f|
        if i = list.index {|x| x =~ /#{f}/i}
          list.unshift list.delete_at i
        end
      end
    end

    def sort_by_after(list, after)
      after.reverse.each do |f|
        if i = list.index {|x| x =~ /#{f}/i}
          list.push list.delete_at i
        end
      end
    end
  end
end

class Hash
  include Linner::HashRecursiveMerge
end

class Array
  include Linner::Sort
end
