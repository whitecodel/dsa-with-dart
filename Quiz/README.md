# DSA Quiz Collection

This folder contains quizzes organized by difficulty levels to test your knowledge of data structures and algorithms.

## Structure

- `easy/` - Contains beginner-level quizzes
- `medium/` - Contains intermediate-level quizzes
- `hard/` - Contains advanced-level quizzes

## Quiz Format

Each quiz is stored in JSON format with the following structure:

```json
{
  "question": "Question text?",
  "type": "multiple-choice",
  "timeLimit": 10,
  "options": ["Option A", "Option B", "Option C", "Option D"],
  "correctAnswer": 0
}
```

Where:

- `title`: The name of the quiz
- `type`: Type of quiz (multiple-choice, true/false, etc.)
- `timeLimit`: Time limit in minutes
- `questions`: Array of question objects with options and correct answer index
