import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { candidateApi } from '../api/candidate-api';
import type { DocumentUploadData, ProposalResponse } from '../types';

// ============ Application Hooks ============

export const useCandidateApplications = () => {
  return useQuery({
    queryKey: ['candidate', 'applications'],
    queryFn: candidateApi.getApplications,
    staleTime: 1000 * 60 * 2, // 2 minutes
  });
};

export const useCandidateApplication = (appId: number) => {
  return useQuery({
    queryKey: ['candidate', 'applications', appId],
    queryFn: () => candidateApi.getApplication(appId),
    enabled: !!appId,
    staleTime: 1000 * 60 * 2,
  });
};

// ============ Document Hooks ============

export const useDocumentRequirements = (appId: number) => {
  return useQuery({
    queryKey: ['candidate', 'applications', appId, 'documents'],
    queryFn: () => candidateApi.getDocumentRequirements(appId),
    enabled: !!appId,
    staleTime: 1000 * 60,
  });
};

export const useUploadDocument = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: async ({
      file,
      documentType,
      applicationId,
    }: {
      file: File;
      documentType: string;
      applicationId: number;
    }) => {
      // Step 1: Upload file to io-service
      const uploadResult = await candidateApi.uploadDocumentFile(
        file,
        documentType,
        applicationId
      );
      
      // Step 2: Create document record in base-service
      const documentData: DocumentUploadData = {
        document_type: documentType,
        title: getDocumentTitle(documentType),
        file_url: uploadResult.file_url,
        file_name: uploadResult.file_name,
        file_size: uploadResult.file_size,
        mime_type: uploadResult.mime_type,
      };
      
      return candidateApi.createDocumentRecord(applicationId, documentData);
    },
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({
        queryKey: ['candidate', 'applications', variables.applicationId],
      });
      queryClient.invalidateQueries({
        queryKey: ['candidate', 'applications', variables.applicationId, 'documents'],
      });
    },
  });
};

// ============ Interview Hooks ============

export const useInterviewInfo = (appId: number) => {
  return useQuery({
    queryKey: ['candidate', 'applications', appId, 'interview'],
    queryFn: () => candidateApi.getInterviewInfo(appId),
    enabled: !!appId,
    staleTime: 1000 * 60,
  });
};

// ============ Exam Hooks ============

export const useExamInfo = (appId: number) => {
  return useQuery({
    queryKey: ['candidate', 'applications', appId, 'exam'],
    queryFn: () => candidateApi.getExamInfo(appId),
    enabled: !!appId,
    staleTime: 1000 * 60,
  });
};

// ============ Proposal Hooks ============

export const useProposalInfo = (appId: number) => {
  return useQuery({
    queryKey: ['candidate', 'applications', appId, 'proposal'],
    queryFn: () => candidateApi.getProposalInfo(appId),
    enabled: !!appId,
    staleTime: 1000 * 60,
  });
};

export const useRespondToProposal = () => {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: ({
      appId,
      response,
    }: {
      appId: number;
      response: ProposalResponse;
    }) => candidateApi.respondToProposal(appId, response),
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({
        queryKey: ['candidate', 'applications', variables.appId],
      });
      queryClient.invalidateQueries({
        queryKey: ['candidate', 'applications', variables.appId, 'proposal'],
      });
      queryClient.invalidateQueries({
        queryKey: ['candidate', 'applications'],
      });
    },
  });
};

// ============ Helpers ============

function getDocumentTitle(documentType: string): string {
  const titles: Record<string, string> = {
    id_card: 'Government-issued ID',
    diploma: 'Educational Diploma',
    certificate: 'Professional Certificate',
    reference: 'Professional Reference',
    other: 'Other Document',
  };
  return titles[documentType] || 'Document';
}

