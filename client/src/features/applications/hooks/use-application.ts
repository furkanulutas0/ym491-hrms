"use client";

import { useMutation } from '@tanstack/react-query';
import { applicationsApi } from '../api/applications-api';
import type {
  UploadAndCheckResponse,
  AnalyzedCVResponse,
  AdditionalFields,
  CreateApplicationRequest,
  JobApplication,
} from '../types';

export function useUploadAndCheckCoverage() {
  return useMutation<UploadAndCheckResponse, Error, File>({
    mutationFn: (file: File) => applicationsApi.uploadAndCheckCoverage(file),
  });
}

export function useAnalyzeCV() {
  return useMutation<
    AnalyzedCVResponse,
    Error,
    { fileUrl: string; additionalFields?: AdditionalFields }
  >({
    mutationFn: ({ fileUrl, additionalFields }) =>
      applicationsApi.analyzeCV(fileUrl, additionalFields),
  });
}

export function useCreateApplication() {
  return useMutation<JobApplication, Error, CreateApplicationRequest>({
    mutationFn: (application: CreateApplicationRequest) =>
      applicationsApi.createApplication(application),
  });
}

