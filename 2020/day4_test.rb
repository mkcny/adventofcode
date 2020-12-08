require "minitest/autorun"
require_relative "day4"

class Day4Tests < Minitest::Test
  def test_height_validator
    validator = REQUIRED_FIELDS_WITH_VALIDATORS['hgt']

    assert validator.("150cm")
    assert validator.("193cm")
    refute validator.("149cm")
    refute validator.("194cm")

    assert validator.("59in")
    assert validator.("76in")
    refute validator.("58in")
    refute validator.("77in")

    refute validator.("77")
    refute validator.("")
  end
end
