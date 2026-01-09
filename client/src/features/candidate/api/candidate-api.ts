import axios from 'axios';
import type {
  Candidate,
  CandidateToken,
  CandidateRegisterData,
  CandidateLoginData,
  CandidateProfileUpdate,
  CandidateApplicationSummary,
  CandidateApplicationDetail,
  DocumentRequirementStatus,
  DocumentUploadData,
  DocumentUploadResponse,
  CandidateDocument,
  InterviewInfo,
  ExamInfo,
  ProposalInfo,
  ProposalResponse
} from '../types';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:6060';

// Create axios instance for candidate API
const candidateAxios = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
});

// Add token to requests
candidateAxios.interceptors.request.use((config) => {
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('candidate_token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
  }
  return config;
});

export const candidateApi = {
  // ============ Auth ============
  
  register: async (data: CandidateRegisterData): Promise<CandidateToken> => {
    const response = await candidateAxios.post<CandidateToken>(
      '/api/base/candidate/auth/register',
      data
    );
    return response.data;
  },

  login: async (data: CandidateLoginData): Promise<CandidateToken> => {
    const response = await candidateAxios.post<CandidateToken>(
      '/api/base/candidate/auth/login',
      data
    );
    return response.data;
  },

  getMe: async (): Promise<Candidate> => {
    const response = await candidateAxios.get<Candidate>(
      '/api/base/candidate/auth/me'
    );
    return response.data;
  },

  forgotPassword: async (email: string): Promise<{ message: string }> => {
    const response = await candidateAxios.post(
      '/api/base/candidate/auth/forgot-password',
      { email }
    );
    return response.data;
  },

  resetPassword: async (token: string, newPassword: string): Promise<{ message: string }> => {
    const response = await candidateAxios.post(
      '/api/base/candidate/auth/reset-password',
      { token, new_password: newPassword }
    );
    return response.data;
  },

  // ============ Profile ============

  getProfile: async (): Promise<Candidate> => {
    const response = await candidateAxios.get<Candidate>(
      '/api/base/candidate/profile'
    );
    return response.data;
  },

  updateProfile: async (data: CandidateProfileUpdate): Promise<Candidate> => {
    const response = await candidateAxios.put<Candidate>(
      '/api/base/candidate/profile',
      data
    );
    return response.data;
  },

  // ============ Applications ============

  getApplications: async (): Promise<CandidateApplicationSummary[]> => {
    const response = await candidateAxios.get<CandidateApplicationSummary[]>(
      '/api/base/candidate/applications'
    );
    return response.data;
  },

  getApplication: async (appId: number): Promise<CandidateApplicationDetail> => {
    const response = await candidateAxios.get<CandidateApplicationDetail>(
      `/api/base/candidate/applications/${appId}`
    );
    return response.data;
  },

  // ============ Documents ============

  getDocumentRequirements: async (appId: number): Promise<DocumentRequirementStatus[]> => {
    const response = await candidateAxios.get<DocumentRequirementStatus[]>(
      `/api/base/candidate/applications/${appId}/documents`
    );
    return response.data;
  },

  uploadDocumentFile: async (
    file: File,
    documentType: string,
    applicationId: number
  ): Promise<DocumentUploadResponse> => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('document_type', documentType);
    formData.append('application_id', applicationId.toString());

    const response = await axios.post<DocumentUploadResponse>(
      `${API_BASE_URL}/api/io/documents/upload`,
      formData,
      {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
        timeout: 60600,
      }
    );
    return response.data;
  },

  createDocumentRecord: async (
    appId: number,
    data: DocumentUploadData
  ): Promise<CandidateDocument> => {
    const response = await candidateAxios.post<CandidateDocument>(
      `/api/base/candidate/applications/${appId}/documents`,
      {
        application_id: appId,
        ...data
      }
    );
    return response.data;
  },

  // ============ Interview ============

  getInterviewInfo: async (appId: number): Promise<InterviewInfo> => {
    const response = await candidateAxios.get<InterviewInfo>(
      `/api/base/candidate/applications/${appId}/interview`
    );
    return response.data;
  },

  // ============ Exam ============

  getExamInfo: async (appId: number): Promise<ExamInfo> => {
    const response = await candidateAxios.get<ExamInfo>(
      `/api/base/candidate/applications/${appId}/exam`
    );
    return response.data;
  },

  // ============ Proposal ============

  getProposalInfo: async (appId: number): Promise<ProposalInfo> => {
    const response = await candidateAxios.get<ProposalInfo>(
      `/api/base/candidate/applications/${appId}/proposal`
    );
    return response.data;
  },

  respondToProposal: async (
    appId: number,
    response: ProposalResponse
  ): Promise<{ message: string; accepted: boolean }> => {
    const res = await candidateAxios.post(
      `/api/base/candidate/applications/${appId}/proposal/respond`,
      response
    );
    return res.data;
  },
};

