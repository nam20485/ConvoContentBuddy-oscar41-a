-- Initialize PostgreSQL with pgvector extension for ConvoContentBuddy

-- Create the database if it doesn't exist
-- (This is handled by environment variables in docker-compose)

-- Connect to the database
\c convobuddy;

-- Enable the pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Create tables for problem metadata and graph relationships
CREATE TABLE IF NOT EXISTS problems (
    id SERIAL PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    description TEXT,
    difficulty VARCHAR(50) CHECK (difficulty IN ('Easy', 'Medium', 'Hard')),
    category VARCHAR(100),
    tags TEXT[],
    leetcode_id INTEGER,
    url VARCHAR(1000),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create table for code solutions
CREATE TABLE IF NOT EXISTS solutions (
    id SERIAL PRIMARY KEY,
    problem_id INTEGER NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    language VARCHAR(50) NOT NULL,
    code TEXT NOT NULL,
    time_complexity VARCHAR(100),
    space_complexity VARCHAR(100),
    explanation TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create table for graph relationships between problems
CREATE TABLE IF NOT EXISTS problem_relations (
    id SERIAL PRIMARY KEY,
    source_problem_id INTEGER NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    target_problem_id INTEGER NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    relation_type VARCHAR(50) NOT NULL,
    strength FLOAT DEFAULT 1.0,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(source_problem_id, target_problem_id, relation_type)
);

-- Create table for storing vector embeddings (primary storage will be Qdrant, but we maintain references here)
CREATE TABLE IF NOT EXISTS problem_vectors (
    id SERIAL PRIMARY KEY,
    problem_id INTEGER NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    vector_provider VARCHAR(50) DEFAULT 'gemini',
    embedding_model VARCHAR(100) DEFAULT 'text-embedding-004',
    dimensions INTEGER NOT NULL,
    qdrant_id UUID, -- Reference to vector in Qdrant
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_problems_title ON problems(LOWER(title));
CREATE INDEX IF NOT EXISTS idx_problems_difficulty ON problems(difficulty);
CREATE INDEX IF NOT EXISTS idx_problems_category ON problems(category);
CREATE INDEX IF NOT EXISTS idx_solutions_problem_id ON solutions(problem_id);
CREATE INDEX IF NOT EXISTS idx_solutions_language ON solutions(language);
CREATE INDEX IF NOT EXISTS idx_problem_relations_source ON problem_relations(source_problem_id);
CREATE INDEX IF NOT EXISTS idx_problem_relations_target ON problem_relations(target_problem_id);
CREATE INDEX IF NOT EXISTS idx_problem_relations_type ON problem_relations(relation_type);
CREATE INDEX IF NOT EXISTS idx_problem_vectors_problem_id ON problem_vectors(problem_id);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for automatic updated_at updates
CREATE TRIGGER update_problems_updated_at 
    BEFORE UPDATE ON problems 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data (will be replaced by actual data seeder)
-- This is just to verify the schema works
INSERT INTO problems (title, description, difficulty, category, tags, leetcode_id, url) VALUES
('Two Sum', 'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.', 'Easy', 'Array', ARRAY['Array', 'Hash Table'], 1, 'https://leetcode.com/problems/two-sum/'),
('Add Two Numbers', 'You are given two non-empty linked lists representing two non-negative integers.', 'Medium', 'Linked List', ARRAY['Linked List', 'Math'], 2, 'https://leetcode.com/problems/add-two-numbers/'),
('Longest Substring Without Repeating Characters', 'Given a string s, find the length of the longest substring without repeating characters.', 'Medium', 'String', ARRAY['String', 'Sliding Window'], 3, 'https://leetcode.com/problems/longest-substring-without-repeating-characters/')
ON CONFLICT (leetcode_id) DO NOTHING;

-- Add some sample problem relations
INSERT INTO problem_relations (source_problem_id, target_problem_id, relation_type, strength) VALUES
(1, 2, 'similar', 0.8),
(1, 3, 'same-difficulty', 0.7),
(2, 3, 'same-category', 0.6)
ON CONFLICT (source_problem_id, target_problem_id, relation_type) DO NOTHING;

-- Add some sample solutions
INSERT INTO solutions (problem_id, language, code, time_complexity, space_complexity) VALUES
(1, 'Python', 'class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i
        return []', 'O(n)', 'O(n)'),
(1, 'Java', 'class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> seen = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (seen.containsKey(complement)) {
                return new int[]{seen.get(complement), i};
            }
            seen.put(nums[i], i);
        }
        return new int[]{};
    }
}', 'O(n)', 'O(n)'),
(1, 'C++', 'class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> seen;
        for (int i = 0; i < nums.size(); i++) {
            int complement = target - nums[i];
            if (seen.find(complement) != seen.end()) {
                return {seen[complement], i};
            }
            seen[nums[i]] = i;
        }
        return {};
    }
};', 'O(n)', 'O(n)')
ON CONFLICT DO NOTHING;

-- Add vector references (these will be populated by the vector seeder)
INSERT INTO problem_vectors (problem_id, dimensions, qdrant_id) VALUES
(1, 1536, '550e8400-e29b-41d4-a716-446655440000'),
(2, 1536, '550e8400-e29b-41d4-a716-446655440001'),
(3, 1536, '550e8400-e29b-41d4-a716-446655440002')
ON CONFLICT DO NOTHING;
