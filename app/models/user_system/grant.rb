# Copyright (c) 2010 Todd Willey <todd@rubidine.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module UserSystem
  class Grant < ActiveRecord::Base
    belongs_to :grant_object, :polymorphic => true
    belongs_to :grant_level
    belongs_to :user
    belongs_to :granting_user, :class_name => 'User'

    named_scope :from, proc{|u|
      u = (u.class < User) ? u.id : u.to_i
      {:conditions => {:granting_user_id => u}}
    }

    named_scope :to, proc{|u|
      u = (u.class < User) ? u.id : u.to_i
      {:conditions => {:user_id => u}}
    }

    named_scope :on_object, proc{|o|
      {:conditions => {
        :grant_object_type => o.class.name,
        :grant_object_id => o.id
      }}
    }

    named_scope :with_level, proc{|l|
      l = [l].flatten
      l.map!{|x| x.to_s}
      {
        :include => [:grant_level],
        :conditions => {:grant_levels => {:name => l}}
      }
    }

    named_scope :unexpired, proc{
      {:conditions => ['expired_at IS NULL or expired_at > ?', Time.now]}
    }

  end
end
