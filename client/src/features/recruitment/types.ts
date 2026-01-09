export interface JobPosting {
  id: number;
  title: string;
  department: string | null;
  location: string | null;
  work_type: string | null;
  status: string | null;
  description: string | null;
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
  salary_range_min: number | null;
  salary_range_max: number | null;
  salary_currency: string | null;
  expiration_date: string | null;
  posting_date: string | null;
  created_at: string;
  updated_at: string | null;
}

export interface JobPostingCreate {
  title: string;
  department: string | null;
  location: string | null;
  work_type: string | null;
  status: string;
  description: string | null;
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
  salary_range_min: number | null;
  salary_range_max: number | null;
  salary_currency: string | null;
  expiration_date: string | null;
}

export type JobPostingUpdate = Partial<JobPostingCreate>;

export interface JobApplication {
  id: number;
  job_posting_id: number;
  candidate_name: string;
  email: string;
  phone: string | null;
  resume_url: string | null;
  cover_letter: string | null;
  portfolio_url: string | null;
  linkedin_url: string | null;
  source: string | null;
  status: string;
  applied_at: string;
  updated_at: string | null;
  
  // Pipeline fields
  pipeline_stage: PipelineStage;
  pipeline_stage_updated_at: string | null;
  ai_review_result: AIReviewResult | null;
  ai_review_score: number | null;
  exam_assigned: boolean;
  exam_platform_id: string | null;
  exam_access_code: string | null;
  exam_started_at: string | null;
  exam_completed_at: string | null;
  exam_score: number | null;
  exam_finalized_score: number | null;
  ai_interview_scheduled_at: string | null;
  ai_interview_completed_at: string | null;
  ai_interview_type: 'video' | 'voice' | null;
  documents_required: DocumentRequirement[] | null;
  documents_submitted: DocumentRequirement[] | null;
  proposal_sent_at: string | null;
  proposal_accepted: boolean | null;
}

// Pipeline types
export type PipelineStage = 'applied' | 'ai_review' | 'exam' | 'ai_interview' | 'cv_verification' | 'proposal';

export interface AIReviewResult {
  score: number;
  explanation: string;
  suitable: boolean;
  strengths: string[];
  concerns: string[];
  matched_requirements: string[];
  missing_requirements: string[];
}

export interface PipelineStageUpdate {
  stage: PipelineStage;
  notes?: string;
}

export interface ExamAssignment {
  platform: string;
  exam_id: string;
  exam_url?: string;
  due_date?: string;
  instructions?: string;
}

export interface ExamResult {
  score: number;
  completed_at: string;
  passed: boolean;
  details?: Record<string, any>;
}

export interface AIInterviewSchedule {
  interview_type: 'video' | 'voice';
  scheduled_at: string;
  duration_minutes?: number;
  meeting_url?: string;
  instructions?: string;
}

export interface DocumentRequirement {
  document_type: string;
  title: string;
  description?: string;
  required: boolean;
  submitted: boolean;
  file_url?: string;
  submitted_at?: string;
}

export interface DocumentUpdate {
  documents: DocumentRequirement[];
}

export interface ProposalData {
  position: string;
  salary_offer?: number;
  start_date?: string;
  benefits?: string[];
  additional_notes?: string;
}

export interface PipelineStageInfo {
  stage: PipelineStage;
  label: string;
  description: string;
  icon: string;
  color: string;
}

// Document Review Types (for HR Admin)

export interface WorkExperienceSummary {
  job_title: string;
  company: string;
  start_date: string | null;
  end_date: string | null;
  is_current: boolean;
}

export interface EducationSummary {
  institution: string;
  degree: string | null;
  field_of_study: string | null;
  start_date: string | null;
  end_date: string | null;
}

export interface CandidateVerificationInfo {
  full_name: string;
  email: string | null;
  phone: string | null;
  current_position: string | null;
  current_company: string | null;
  total_experience_years: number | null;
  highest_degree: string | null;
  field_of_study: string | null;
  institution: string | null;
  education: EducationSummary[];
  work_experience: WorkExperienceSummary[];
  skills: string[];
  certifications: string[];
}

export interface PortalDocument {
  id: number;
  portal_user_id: number;
  application_id: number;
  document_type: string;
  title: string | null;
  file_url: string;
  file_name: string | null;
  file_size: number | null;
  mime_type: string | null;
  status: 'pending' | 'approved' | 'rejected';
  uploaded_at: string;
  reviewed_at: string | null;
  reviewed_by: number | null;
  reviewer_notes: string | null;
}

export interface DocumentsForReviewResponse {
  application_id: number;
  candidate_name: string;
  email: string;
  documents: PortalDocument[];
  candidate_info: CandidateVerificationInfo;
  all_required_approved: boolean;
}

export interface DocumentReviewRequest {
  status: 'approved' | 'rejected';
  reviewer_notes?: string;
}

