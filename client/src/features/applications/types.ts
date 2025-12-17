export interface MissingFieldsDetail {
  awarded_fields: string[];
  missing_fields: string[];
}

export interface CoverageBreakdown {
  personal_information: number;
  summary: number;
  work_experience: number;
  education: number;
  skills: number;
  projects: number;
  certifications: number;
  publications: number;
  awards: number;
  volunteering: number;
  additional_information: number;
}

export interface CoverageDetails {
  personal_information?: MissingFieldsDetail;
  summary?: MissingFieldsDetail;
  work_experience?: MissingFieldsDetail;
  education?: MissingFieldsDetail;
  skills?: MissingFieldsDetail;
  projects?: MissingFieldsDetail;
  certifications?: MissingFieldsDetail;
  publications?: MissingFieldsDetail;
  awards?: MissingFieldsDetail;
  volunteering?: MissingFieldsDetail;
  additional_information?: MissingFieldsDetail;
}

export interface CoverageResponse {
  cover_rate: number;
  breakdown: CoverageBreakdown;
  details: CoverageDetails;
  file_url: string;
}

export interface UploadAndCheckResponse {
  success: boolean;
  file_url: string;
  coverage?: CoverageResponse;
  error?: string;
}

export interface AdditionalFields {
  city?: string;
  country?: string;
  languages?: string[];
  driving_license?: string;
  military_status?: string;
  availability?: string;
  willing_to_relocate?: boolean;
  willing_to_travel?: boolean;
  hobbies?: string[];
}

export interface AnalyzedCVData {
  employee_id?: string;
  full_name?: string;
  email?: string;
  phone?: string;
  location?: string;
  linkedin_url?: string;
  github_url?: string;
  professional_title?: string;
  professional_summary?: string;
  total_experience_years?: number;
  current_position?: string;
  current_company?: string;
  work_experience?: string;
  highest_degree?: string;
  field_of_study?: string;
  institution?: string;
  education_details?: string;
  technical_skills?: string;
  soft_skills?: string;
  languages?: string;
  certifications?: string;
  certifications_count?: number;
  projects?: string;
  projects_count?: number;
  [key: string]: unknown;
}

export interface AnalyzedCVResponse {
  success: boolean;
  data?: AnalyzedCVData;
  error?: string;
}

export interface CreateApplicationRequest {
  job_posting_id: number;
  candidate_name: string;
  email: string;
  phone?: string;
  resume_url: string;
  cover_letter?: string;
  portfolio_url?: string;
  linkedin_url?: string;
  source?: string;
}

export interface JobApplication {
  id: number;
  job_posting_id: number;
  candidate_name: string;
  email: string;
  phone?: string;
  resume_url?: string;
  cover_letter?: string;
  portfolio_url?: string;
  linkedin_url?: string;
  source?: string;
  status: string;
  applied_at: string;
  updated_at?: string;
}

// Application modal step types
export type ApplicationStep = 
  | 'upload'
  | 'checking'
  | 'coverage-result'
  | 'missing-fields'
  | 'analyzing'
  | 'success'
  | 'error';

export interface ApplicationState {
  step: ApplicationStep;
  file?: File;
  fileUrl?: string;
  coverage?: CoverageResponse;
  additionalFields?: AdditionalFields;
  analyzedData?: AnalyzedCVData;
  error?: string;
}

// Helper to get all missing fields from coverage response
export function getAllMissingFields(details: CoverageDetails): string[] {
  const allMissing: string[] = [];
  
  Object.entries(details).forEach(([category, detail]) => {
    if (detail?.missing_fields) {
      detail.missing_fields.forEach((field: string) => {
        allMissing.push(`${category}.${field}`);
      });
    }
  });
  
  return allMissing;
}

// Helper to check if a field is fillable by user
export function isUserFillableField(field: string): boolean {
  const fillableFields = [
    'personal_information.address.city',
    'personal_information.address.country',
    'skills.languages',
    'additional_information.driving_license',
    'additional_information.military_status',
    'additional_information.availability',
    'additional_information.willing_to_relocate',
    'additional_information.willing_to_travel',
    'additional_information.hobbies',
  ];
  
  return fillableFields.some(f => field.includes(f.split('.').pop() || ''));
}

