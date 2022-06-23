class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers
  accepts_nested_attributes_for :answers

  #kaminari
  paginates_per 5

  #scope e um metodo rails usado para pesquisas em banco de dados
  scope :_search_subject_, -> (page, subject_id){
    includes(:answers)
    .where(subject_id: subject_id)
    .page(page)
  }


  scope :_search_, -> (page, term){
    includes(:answers)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .page(page)
  }

  scope :last_questions, ->(page) {
    Question.includes(:answers).order('created_at desc').page(page)
  }
end
