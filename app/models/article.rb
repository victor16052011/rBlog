class Article < ApplicationRecord
	include AASM

	belongs_to :user
	has_many :coments
	has_many :has_categories
	has_many :categories, through: :has_categories


	validates :titulo, presence: true, uniqueness: true
	validates :cuerpo, presence: true, length: {minimum: 20}
	before_save :set_visit_count
	after_create :save_categories
	after_create :send_mail

	has_attached_file :cover, styles: { medium: "1280x720", thumb:"400x200" }

	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/


	scope :publicados, -> { where(state: "publicado") }

	scope :ultimos, -> { order("created_at DESC") }

	def categories=(value)
		@categories = value
	end

	def update_visit_count
		self.save if self.contador.nil?
		self.update({contador: self.contador + 1})
	end
	aasm column: "state" do
			state :en_borrador, initial: true
			state :publicado

			event :publicado do
				transitions from: :en_borrador, to: :publicado
			end

			event :nopublicado do
				transitions from: :publicado, to: :en_borrador
			end

	end

	def send_mail
		ArticleMailer.new_article(self).deliver_later
	end

	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create({category_id: category_id, article_id: self.id})
		end
	end

	def set_visit_count
		self.contador ||= 0
	end
end
