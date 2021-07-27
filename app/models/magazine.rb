class Magazine < ActiveRecord::Base
    has_many :subscriptions, dependent: :destroy
    has_many :readers, through: :subscriptions

    def email_list
        # readers.map { |person| person.email }.join(";")
        readers.pluck(:email).join(";")
    end

    def self.most_popular
        # all.max_by { |mag| mag.subscriptions.count } This works, but does A LOT of SQL queries! 
        includes(:subscriptions).all.max_by {|mag| mag.subscriptions.length}
    end
end