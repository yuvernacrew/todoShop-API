module Api
  module V1
    class RewardsController < ApplicationController
      before_action :set_reward, only: [:show, :update, :destroy, :getReword]
      skip_before_action :authenticate_user_from_token!

      def index
        rewards = Reward.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: '全てのご褒美を取得しました', data: rewards }
      end

      def show
        render json: { status: 'SUCCESS', message: 'ご褒美を取得しました', data: @reward }
      end

      def create
        reward = Reward.new(reward_params)
        if reward.save
          render json: { status: '新しいご褒美を追加しました', data: reward }
        else
          render json: { status: 'ERROR', data: reward.errors }
        end
      end

      def getReword
        user = User.find(@reward.user_id)
        user.point = user.point - @reward.point
        if user.save
          @reward.destroy
          render json: { status: 'SUCCESS', message: 'ご褒美を手に入れました', data: @reward }
        else
          render json: { status: 'ERROR', data: reward.errors }
        end
      end

      def destroy
        @reward.destroy
        render json: { status: 'SUCCESS', message: 'ご褒美を削除しました', data: @reward.point }
      end

      def update
        if @reward.update(reward_params)
          render json: { status: 'SUCCESS', message: 'ご褒美を更新しました', data: @reward }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @reward.errors }
        end
      end

      private

      def set_reward
        @reward = Reward.find(params[:id])
      end

      def reward_params
        params.require(:reward).permit(:title, :user_id, :point)
      end
    end
  end
end