require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Mocks
    context "OnceCounts" do
      setup do
        disable_auto_verification_of_mocks
        @mock = mock("test mock")
      end

      specify "once should fail when called once with wrong args" do
        @mock.should_receive(:random_call).once.with("a", "b", "c")
        lambda do
          @mock.random_call("d", "e", "f")
        end.should raise_error(MockExpectationError)
      end

      specify "once should fail when called twice" do
        @mock.should_receive(:random_call).once
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.__verify
        end.should raise_error(MockExpectationError)
      end
      
      specify "once should fail when not called" do
        @mock.should_receive(:random_call).once
        lambda do
          @mock.__verify
        end.should raise_error(MockExpectationError)
      end

      specify "once should pass when called once" do
        @mock.should_receive(:random_call).once
        @mock.random_call
        @mock.__verify
      end

      specify "once should pass when called once with specified args" do
        @mock.should_receive(:random_call).once.with("a", "b", "c")
        @mock.random_call("a", "b", "c")
        @mock.__verify
      end

      specify "once should pass when called once with unspecified args" do
        @mock.should_receive(:random_call).once
        @mock.random_call("a", "b", "c")
        @mock.__verify
      end
    end
  end
end