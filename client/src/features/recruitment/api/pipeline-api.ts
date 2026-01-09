import { api } from '@/lib/api';
import {
  JobApplication,
  PipelineStage,
  PipelineStageUpdate,
  AIReviewResult,
  ExamAssignment,
  ExamResult,
  AIInterviewSchedule,
  DocumentUpdate,
  ProposalData
} from '../types';

export const pipelineApi = {
  // Get applications by pipeline stage
  getApplicationsByStage: async (jobId: number, stage: PipelineStage): Promise<JobApplication[]> => {
    const response = await api.get<JobApplication[]>(`/api/base/recruitment/jobs/${jobId}/pipeline/${stage}`);
    return response as unknown as JobApplication[];
  },

  // Advance application to next stage
  advanceApplication: async (appId: number, stageUpdate: PipelineStageUpdate): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/pipeline/advance`, stageUpdate);
    return response as unknown as JobApplication;
  },

  // Update AI review results
  updateAIReview: async (appId: number, reviewResult: AIReviewResult): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/ai-review`, reviewResult);
    return response as unknown as JobApplication;
  },

  // Assign exam to application
  assignExam: async (appId: number, examData: ExamAssignment): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/assign-exam`, examData);
    return response as unknown as JobApplication;
  },

  // Update exam results (webhook)
  updateExamResults: async (appId: number, examResult: ExamResult): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/exam-results`, examResult);
    return response as unknown as JobApplication;
  },

  // Schedule AI interview
  scheduleInterview: async (appId: number, interviewData: AIInterviewSchedule): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/schedule-interview`, interviewData);
    return response as unknown as JobApplication;
  },

  // Simulate completing AI interview (for development/testing)
  simulateInterviewComplete: async (appId: number): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/simulate-interview-complete`, {});
    return response as unknown as JobApplication;
  },

  // Update documents for CV verification
  updateDocuments: async (appId: number, documentUpdate: DocumentUpdate): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/documents`, documentUpdate);
    return response as unknown as JobApplication;
  },

  // Send proposal to candidate
  sendProposal: async (appId: number, proposalData: ProposalData): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/send-proposal`, proposalData);
    return response as unknown as JobApplication;
  },

  // Trigger AI review for application
  triggerAIReview: async (appId: number): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/trigger-ai-review`, {});
    return response as unknown as JobApplication;
  },
  // Assign exam to application (v2 - integrated with exam system)
  assignExamV2: async (appId: number, examData: ExamAssignment): Promise<JobApplication> => {
    const response = await api.post<JobApplication>(`/api/base/recruitment/applications/${appId}/assign-exam-v2`, examData);
    return response as unknown as JobApplication;
  },
  
};

