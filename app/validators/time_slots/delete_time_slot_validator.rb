module TimeSlots
  class DeleteTimeSlotValidator < ActiveModel::Validator
    def validate(record)
      if record.date.before?(Date.current)
        record.errors.add :date, "過去の日付は選択できません。正しい日付を選択してください。"
      elsif record.date.before?(Date.current + 1)
        record.errors.add :date, "当日の予定は削除できません。"
      elsif record.date.after?(Date.current + 3.months)
        record.errors.add :date, "は3ヶ月以降の日付は選択できません。"
      end
    end
  end
end