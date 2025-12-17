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
}

