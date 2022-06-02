class ResultSubmissionsController < ApplicationController
  before_action :set_result_submission, only: %i[show edit update destroy]

  # GET /result_submissions or /result_submissions.json
  def index
    @result_submissions = ResultSubmission.all
  end

  # GET /result_submissions/1 or /result_submissions/1.json
  def show; end

  # GET /result_submissions/new
  def new
    @result_submission = ResultSubmission.new
  end

  # GET /result_submissions/1/edit
  def edit; end

  # POST /result_submissions or /result_submissions.json
  def create
    @result_submission = ResultSubmission.new(result_submission_params)

    respond_to do |format|
      if @result_submission.save
        format.html { redirect_to root_url, notice: 'Result submission was successfully created.' }
        format.json { render :show, status: :created, location: @result_submission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @result_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /result_submissions/1 or /result_submissions/1.json
  def update
    respond_to do |format|
      if @result_submission.update(result_submission_params)
        format.html do
          redirect_to result_submission_url(@result_submission), notice: 'Result submission was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @result_submission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @result_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_submissions/1 or /result_submissions/1.json
  def destroy
    @result_submission.destroy

    respond_to do |format|
      format.html { redirect_to result_submissions_url, notice: 'Result submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_result_submission
    @result_submission = ResultSubmission.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def result_submission_params
    params.require(:result_submission).permit(:user_id, :wordle_id, :share_text)
  end
end
