import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { pipelineApi } from '../api/pipeline-api';
import {
  PipelineStage,
  PipelineStageUpdate,
  AIReviewResult,
  ExamAssignment,
  ExamResult,
  AIInterviewSchedule,
  DocumentUpdate,
  ProposalData
} from '../types';

// Query: Get applications by pipeline stage
export const usePipelineApplications = (jobId: number, stage: PipelineStage) => {
  return useQuery({
    queryKey: ['pipeline-applications', jobId, stage],
    queryFn: () => pipelineApi.getApplicationsByStage(jobId, stage),
    enabled: !!jobId && !!stage,
  });
};

// Mutation: Advance application to next stage
export const useAdvanceApplication = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, stageUpdate }: { appId: number; stageUpdate: PipelineStageUpdate }) =>
      pipelineApi.advanceApplication(appId, stageUpdate),
    onSuccess: (data) => {
      // Invalidate queries to refresh data
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Update AI review
export const useUpdateAIReview = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, reviewResult }: { appId: number; reviewResult: AIReviewResult }) =>
      pipelineApi.updateAIReview(appId, reviewResult),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};
 
// Mutation: Assign exam
export const useAssignExam = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, examData }: { appId: number; examData: ExamAssignment }) =>
      pipelineApi.assignExam(appId, examData),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};
export const useAssignExamV2 = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, examData }: { appId: number; examData: ExamAssignment }) =>
      pipelineApi.assignExamV2(appId, examData),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Update exam results
export const useUpdateExamResults = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, examResult }: { appId: number; examResult: ExamResult }) =>
      pipelineApi.updateExamResults(appId, examResult),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Schedule interview
export const useScheduleInterview = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, interviewData }: { appId: number; interviewData: AIInterviewSchedule }) =>
      pipelineApi.scheduleInterview(appId, interviewData),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Simulate interview completion (for development/testing)
export const useSimulateInterviewComplete = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (appId: number) => pipelineApi.simulateInterviewComplete(appId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Update documents
export const useUpdateDocuments = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, documentUpdate }: { appId: number; documentUpdate: DocumentUpdate }) =>
      pipelineApi.updateDocuments(appId, documentUpdate),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Send proposal
export const useSendProposal = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({ appId, proposalData }: { appId: number; proposalData: ProposalData }) =>
      pipelineApi.sendProposal(appId, proposalData),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

// Mutation: Trigger AI review
export const useTriggerAIReview = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (appId: number) => pipelineApi.triggerAIReview(appId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['pipeline-applications'] });
      queryClient.invalidateQueries({ queryKey: ['job-applications'] });
    },
  });
};

