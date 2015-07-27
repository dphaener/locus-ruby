require 'test_helper'

class ResponseTest < MiniTest::Test
  context "#success?" do
    should "be true if the status is in the 200..299 range" do
      (200..299).each do |status|
        subject = Locus::Response.new(status, {})
        assert subject.success?
      end
    end

    should "be false if the status code is a 404" do
      subject = Locus::Response.new(404, {})
      refute subject.success?
    end

    should "be false if the status code is a 500" do
      subject = Locus::Response.new(500, {})
      refute subject.success?
    end
  end

  context "#members" do
    setup do
      @body = {
        "id": 123,
        "ts": "2014-04-01T12:00:00-07:00",
        "W_avg": 23.717,
        "Wh_sum": 5936
      }
        
      @subject = Locus::Response.new(200, @body, "component")
    end

    should "parse the response properly and make the members available via a method call" do
      assert_equal Locus::Component, @subject.members.class
      assert_equal 123, @subject.component.id
      assert_equal "2014-04-01T12:00:00-07:00", @subject.component.ts
      assert_equal 23.717, @subject.component.W_avg
      assert_equal 5936, @subject.component.Wh_sum
    end

    should "create a collection when the response is an array" do
      body = [
        {
          "id": 123,
          "ts": "2014-04-01T12:00:00-07:00",
          "W_avg": 23.717,
          "Wh_sum": 5936
        }
      ]

      subject = Locus::Response.new(200, body, "component")

      assert_equal Locus::Components, subject.members.class
    end
  end
end
