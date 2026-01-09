// ============ Candidate Auth Types ============

export interface CandidateRegisterData {
  email: string;
  password: string;
  full_name: string;
  phone?: string;
}

export interface CandidateLoginData {
  email: string;
  password: string;
}

export interface CandidateToken {
  access_token: string;
  token_type: string;
  candidate: Candidate;
}

export interface Candidate {
  id: number;
  email: string;
  full_name: string | null;
  phone: string | null;
  linkedin_url: string | null;
  portfolio_url: string | null;
  is_active: boolean;
  email_verified: boolean;
  created_at: string;
  updated_at: string | null;
}

export interface CandidateProfileUpdate {
  full_name?: string;
  phone?: string;
  linkedin_url?: string;
  portfolio_url?: string;
}

// ============ Application Types ============

export interface CandidateApplicationSummary {
  id: number;
  job_title: string;
  company_name: string;
  department: string | null;
  location: string | null;
  pipeline_stage: PipelineStage;
  applied_at: string;
  status: string;
  exam_assigned: boolean;
  exam_completed: boolean;
  exam_score: number | null;
  interview_scheduled: boolean;
  interview_completed: boolean;
  interview_type: 'video' | 'voice' | null;
  interview_scheduled_at: string | null;
  documents_pending: number;
  documents_approved: number;
  proposal_sent: boolean;
  proposal_accepted: boolean | null;
}

export interface CandidateApplicationDetail extends CandidateApplicationSummary {
  job_description: string | null;
  exam_access_code: string | null;
  exam_platform_id: string | null;
  documents: CandidateDocument[];
  document_requirements: DocumentRequirementStatus[];
}

export type PipelineStage = 'applied' | 'ai_review' | 'exam' | 'ai_interview' | 'cv_verification' | 'proposal';

// ============ Document Types ============

export interface CandidateDocument {
  id: number;
  candidate_id: number;
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

export interface DocumentRequirementStatus {
  document_type: string;
  title: string;
  description: string | null;
  required: boolean;
  submitted: boolean;
  status: 'pending' | 'approved' | 'rejected' | null;
  document: CandidateDocument | null;
}

export interface DocumentUploadData {
  document_type: string;
  title?: string;
  file_url: string;
  file_name?: string;
  file_size?: number;
  mime_type?: string;
}

export interface DocumentUploadResponse {
  success: boolean;
  file_url: string;
  file_name: string;
  file_size: number;
  mime_type: string;
  document_type: string;
  application_id: number;
}

// ============ Interview Types ============

export interface InterviewInfo {
  interview_type: 'video' | 'voice' | null;
  scheduled_at: string | null;
  completed_at: string | null;
  meeting_url: string | null;
  instructions: string | null;
}

// ============ Exam Types ============

export interface ExamInfo {
  assigned: boolean;
  platform_id: string | null;
  access_code: string | null;
  exam_url: string | null;
  started_at: string | null;
  completed_at: string | null;
  score: number | null;
  instructions: string | null;
}

// ============ Proposal Types ============

export interface ProposalInfo {
  sent_at: string | null;
  accepted: boolean | null;
  position: string | null;
  salary_offer: number | null;
  salary_currency: string;
  start_date: string | null;
  benefits: string[];
  additional_notes: string | null;
}

export interface ProposalResponse {
  accepted: boolean;
  notes?: string;
}

// ============ Pipeline Stage Info ============

export interface PipelineStageInfo {
  stage: PipelineStage;
  label: string;
  description: string;
  icon: string;
  color: string;
}

export const PIPELINE_STAGES: PipelineStageInfo[] = [
  {
    stage: 'applied',
    label: 'Applied',
    description: 'Application submitted',
    icon: 'description',
    color: 'text-blue-500'
  },
  {
    stage: 'ai_review',
    label: 'AI Review',
    description: 'Your application is being reviewed by our AI',
    icon: 'smart_toy',
    color: 'text-purple-500'
  },
  {
    stage: 'exam',
    label: 'Assessment',
    description: 'Complete the skills assessment',
    icon: 'quiz',
    color: 'text-orange-500'
  },
  {
    stage: 'ai_interview',
    label: 'AI Interview',
    description: 'Participate in an AI-powered interview',
    icon: 'videocam',
    color: 'text-cyan-500'
  },
  {
    stage: 'cv_verification',
    label: 'Verification',
    description: 'Submit required documents for verification',
    icon: 'verified',
    color: 'text-green-500'
  },
  {
    stage: 'proposal',
    label: 'Offer',
    description: 'Review and respond to job offer',
    icon: 'handshake',
    color: 'text-emerald-500'
  }
];

