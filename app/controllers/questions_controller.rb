class QuestionsController < ApplicationController
  # 質問一覧表示
  def index
    @question = Question.all
  end

  # 質問の詳細
  def show
    # p params[:id]
    @question = Question.find(params[:id])
    # p @question
  end

  # 質問の作成
  def new
    @question = Question.new
  end

  # 質問の登録
  def create
    # Questionモデルを初期化
    @question = Question.new(question_params)
    # QuestionモデルをDBへ保存
    if @question.save
    # showへリダイレクト
      redirect_to @question
    else
      render 'new', status: :unprocessable_entity #status_code 422へレンダリングします。
    end
  end

  # 質問の編集
  def edit
    @question = Question.find(params[:id])
  end

  # 質問の更新
  def update
    @question = Question.find(params[:id]) #データベースからparams[:id]を元にレコードを作成
    if @question.update(question_params)
      redirect_to @question #登録完了時は、質問詳細ページへ
    else
      render 'edit', status: :unprocessable_entity # 失敗時には、もう一度編集ページを表示
    end
  end

  # 質問の削除
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to question_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :name, :content)
  end
end