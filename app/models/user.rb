# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  name               :string(255)      not null
#  sub                :string(255)      not null
#  preferred_username :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
end
