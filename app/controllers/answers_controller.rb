class AnswersController < ApplicationController
  before_action :authenticate_user!,only: [:edit,:update,:destroy,:new,:create]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers.paginate(page: params[:page])
    respond_with(@question,@answers)
  end

  def show
    respond_with(@question, @answer)
  end

  def new
    @question=Question.find(params[:question_id])
    @answer = @question.answers.new user: current_user
    respond_with(@question, @answer)
  end

  def edit
        @question = Question.find(params[:question_id])
        @answer=@question.answers.find(params[:id])
        if current_user != @question.user
         flash[:danger] = "u dont have permission."
        redirect_to root_url
        end
  end

  def create
    @question=Question.find(params[:question_id])
    @answer = @question.answers.new({user: current_user}.merge!(answer_params))
    @answer.save
    respond_with(@question,@answer)
  end

  def update
    @question=Question.find(params[:question_id])
    @answer=@question.answers.find(params[:id])
    if current_user == @answer.user
        @answer.update(answer_params)
      end
    respond_with(@question,@answer)
  end

  def destroy
    @question=Question.find(params[:question_id])
    @answer=Answer.find(params[:id])
    if current_user == @answer.user
            @answer.destroy
        end
    respond_with(@question,@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end
end
