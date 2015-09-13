require 'test_helper'

class TaskScoresControllerTest < ActionController::TestCase
  setup do
    @task_score = task_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_score" do
    assert_difference('TaskScore.count') do
      post :create, task_score: { content: @task_score.content, score: @task_score.score, task_id: @task_score.task_id, user_id: @task_score.user_id }
    end

    assert_redirected_to task_score_path(assigns(:task_score))
  end

  test "should show task_score" do
    get :show, id: @task_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_score
    assert_response :success
  end

  test "should update task_score" do
    patch :update, id: @task_score, task_score: { content: @task_score.content, score: @task_score.score, task_id: @task_score.task_id, user_id: @task_score.user_id }
    assert_redirected_to task_score_path(assigns(:task_score))
  end

  test "should destroy task_score" do
    assert_difference('TaskScore.count', -1) do
      delete :destroy, id: @task_score
    end

    assert_redirected_to task_scores_path
  end
end
